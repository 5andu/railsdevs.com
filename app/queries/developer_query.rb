class DeveloperQuery
  include Pagy::Backend

  alias_method :build_pagy, :pagy

  delegate :countries, to: :@country_filter

  def search_query
    @query_filter.query
  end

  attr_reader :options

  def initialize(options = {})
    @options = options
    @items_per_page = options.delete(:items_per_page)
    @sort = options.delete(:sort)
    @country_filter = Filters::CountryFilter.new(options)
    @utc_offsets = options.delete(:utc_offsets)
    @role_types = options.delete(:role_types)
    @role_levels = options.delete(:role_levels)
    @include_not_interested = options.delete(:include_not_interested)
    @query_filter = Filters::QueryFilter.new(options)
  end

  def filters
    @filters = {
      sort:,
      utc_offsets:,
      role_types:,
      role_levels:,
      include_not_interested:,
      search_query: @query_filter.query,
      countries: @country_filter.countries
    }
  end

  def pagy
    @pagy ||= query_and_paginate.first
  end

  def records
    @records ||= query_and_paginate.last
  end

  def featured_records
    if pagy.page == 1 && empty_search?
      @featured_records ||= Developer.featured
    else
      Developer.none
    end
  end

  def sort
    @sort.to_s.downcase.to_sym == :availability ? :availability : :newest
  end

  def utc_offsets
    @utc_offsets.to_a.reject(&:blank?).map(&:to_f)
  end

  def role_types
    @role_types.to_a.reject(&:blank?).map(&:to_sym)
  end

  def role_levels
    @role_levels.to_a.reject(&:blank?).map(&:to_sym)
  end

  def include_not_interested
    ActiveModel::Type::Boolean.new.cast(@include_not_interested)
  end

  private

  def query_and_paginate
    @_records = Developer.includes(:role_type).with_attached_avatar.visible
    sort_records
    country_filter_records
    utc_offset_filter_records
    role_type_filter_records
    role_level_filter_records
    search_status_filter_records
    search_query_filter_records
    @pagy, @records = build_pagy(@_records, items: items_per_page)
  end

  def items_per_page
    @items_per_page || Pagy::DEFAULT[:items]
  end

  def empty_search?
    utc_offsets.empty? &&
      role_types.empty? &&
      role_levels.empty? &&
      @query_filter.empty? &&
      @country_filter.empty? &&
      !include_not_interested
  end

  def sort_records
    if sort == :availability
      @_records.merge!(Developer.available_first)
    else
      @_records.merge!(Developer.newest_first)
    end
  end

  def country_filter_records
    @country_filter.filter(@_records)
  end

  def utc_offset_filter_records
    if utc_offsets.any?
      @_records.merge!(Developer.filter_by_utc_offsets(utc_offsets))
    end
  end

  def role_type_filter_records
    @_records.merge!(Developer.filter_by_role_types(role_types)) if role_types.any?
  end

  def role_level_filter_records
    @_records.merge!(Developer.filter_by_role_levels(role_levels)) if role_levels.any?
  end

  def search_status_filter_records
    @_records.merge!(Developer.actively_looking.or(Developer.open)) unless include_not_interested
  end

  def search_query_filter_records
    @query_filter.filter(@_records)
  end

  # Needed for #pagy (aliased to #build_pagy) helper.
  def params
    options
  end
end
