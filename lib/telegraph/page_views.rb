module Telegraph
  class PageViews
    attr_reader :views

    def initialize(attrs)
      @views = attrs['views']
    end
  end
end