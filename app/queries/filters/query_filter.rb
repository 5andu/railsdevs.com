module Filters
  class QueryFilter
    attr_reader :query

    alias_method :search_query, :query

    def initialize(options)
      @query = options[:search_query].to_s.strip
    end

    def filter(records)
      unless search_query.empty?
        records.merge!(Developer.filter_by_search_query(query))
      end
    end

    def empty?
      query.blank?
    end
  end
end
