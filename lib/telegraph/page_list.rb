module Telegraph
  class PageList
    include Enumerable

    attr_reader :total_count, :pages

    def initialize(attrs = {})
      @total_count = attrs['total_count']
      @pages = create_pages(attrs['pages'])
    end

    def each(&block)
      pages.each { |page| block.call(page) }
    end

    private

    def create_pages(attr)
      attr.map { |page_attrs| Page.new(page_attrs) }
    end
  end
end