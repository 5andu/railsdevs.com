module Filters
  class CountryFilter
    attr_reader :countries

    def initialize(options)
      @countries = options[:countries].to_a.reject(&:blank?)
    end

    def filter(records)
      if countries.any?
        records.merge!(Developer.filter_by_countries(countries))
      end
    end

    def empty?
      countries.none?
    end
  end
end
