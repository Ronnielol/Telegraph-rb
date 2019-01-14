require 'nokogiri'

module Telegraph::HTMLConverter
  def html_to_content(html)
    nodes = Nokogiri::HTML.fragment(html).children
    nodes.map { |node| process_node(node) }
  end

  private

  def process_node(node)
    return node.text if node.text?
    return unless node.element?

    node_element = { tag: node.name, children: [] }

    if node.attributes.any?
      node_element[:attrs] = {}
      node.attribute_nodes.each do |attr|
        next unless attr.name == 'href' || attr.name == 'src'
        node_element[:attrs][attr.name] = attr.value
      end
    end

    if node.children.any?
      node.children.each { |child| node_element[:children] << process_node(child) }
    end

    node_element
  end
end
