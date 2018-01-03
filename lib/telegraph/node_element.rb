module Telegraph
  class NodeElement
    AVAILABLE_TAGS = %w{
      a
      aside
      b
      blockquote
      br
      code
      em
      figcaption
      figure
      h3
      h4
      hr
      i
      iframe
      img
      li
      ol
      p
      pre
      s
      strong
      u
      ul
      video
    }

    AVAILABLE_ATTRIBUTES = %w{ href src }

    attr_reader :tag, :attrs, :children

    def initialize(tag, attrs = {}, children = [])
      check_tag(tag)
      check_attrs(attrs)
      @tag = tag
      @attrs = attrs
      @children = children
    end

    private

    def check_tag(tag)
      unless AVAILABLE_TAGS.include?(tag)
        raise ArgumentError, "Wrong tag: '#{tag}'. Check available tags."
      end
    end

    def check_attrs(attrs)
      unavailable_attr = attrs.detect do |k, v|
        !AVAILABLE_ATTRIBUTES.include?(k)
      end
      if unavailable_attr
        raise ArgumentError, "Wrong attribute: '#{unavailable_attr.first}'. Check available attributes."
      end
    end
  end
end