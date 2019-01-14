module Telegraph
  class Page < Dry::Struct
    transform_keys(&:to_sym)

    attribute :path, Telegraph::Types::Strict::String
    attribute :url, Telegraph::Types::Strict::String
    attribute :title, Telegraph::Types::Strict::String
    attribute :description, Telegraph::Types::Strict::String
    attribute :views, Telegraph::Types::Strict::Integer
    attribute :can_edit, Telegraph::Types::Bool.meta(omittable: true)
    attribute :author_name, Telegraph::Types::String
    attribute :author_url, Telegraph::Types::String.meta(omittable: true)
    attribute :content, Telegraph::Types::Array.meta(omittable: true)

    def self.create(title:, author_name:, author_url:, content:, return_content: false)
      params = {
        title: title,
        author_name: author_name,
        author_url: author_url,
        content: content,
        return_content: return_content,
        access_token: client.token
      }
      response = client.post('createPage', params)
      new(response)
    end

    def self.get(path:, return_content: false)
      params = {
        path: path,
        return_content: return_content,
        access_token: client.token
      }
      response = client.get('getPage', params)
      new(response)
    end

    def self.get_views(path:, year: nil, month: nil, day: nil, hour: nil)
      params = { path: path }
      time_params = {
        year: year,
        month: month,
        day: day,
        hour: hour
      }
      params.merge(time_params) if time_params.values.compact.any?
      response = client.get('getViews', params)
      response[:views]
    end

    def edit(title:, content:, author_name: nil, author_url: nil)
      params = {
        path: path,
        title: title,
        content: content,
        author_name: author_name,
        author_url: author_url,
        access_token: client.token
      }
      response = client.post('editPage', params)
      new(response)
    end

    private

    def self.client
      @client ||= Telegraph.client
    end

    def client
      @client ||= Telegraph.client
    end
  end
end
