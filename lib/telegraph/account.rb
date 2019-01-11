module Telegraph
  class Account < Dry::Struct
    include Telegraph::Connection

    transform_keys(&:to_sym)

    attribute :access_token, Types::Strict::String.meta(omittable: true)
    attribute :short_name, Types::Strict::String
    attribute :author_name, Types::Strict::String
    attribute :auth_url, Types::Strict::String
    attribute :author_url, Types::Strict::String
    attribute :page_count, Types::String.meta(omittable: true)

    FIELDS = %w(short_name author_name author_url auth_url page_count)

    def self.create(short_name:, author_name:, author_url:)
      params = {
        short_name: short_name,
        author_name: author_name,
        author_url: author_url
      }
      response = post('createAccount', params)
      new(response)
    end

    def self.get_account_info(fields: [], access_token:)
      fields = FIELDS unless fields.any?
      params = {
        fields: fields,
        access_token: access_token
      }
      response = get('getAccountInfo', params)
      new(response)
    end

    def edit(short_name:, author_name:, author_url:)
      params = {
        short_name: short_name,
        author_name: author_name,
        author_url: author_url,
        access_token: access_token
      }
      response = get('editAccountInfo', params)
      new(response)
    end

    def revoke_token
      response = get('getAccountInfo', access_token: access_token)
      new(response)
    end

    def create_page(title:, author_name:, author_url:, content:, return_content: false)
      params = {
        title: title,
        author_name: author_name,
        author_url: author_url,
        content: content,
        return_content: return_content,
        access_token: access_token
      }
      response = post('createPage', params)
      Page.new(response)
    end

    def get_page(path:, return_content: false)
      params = {
        path: path,
        return_content: return_content,
        access_token: access_token
      }
      response = get('getPage', params)
      Page.new(response)
    end

    def get_page_list(offset: 0, limit: 50)
      params = {
        offset: offset,
        limit: limit,
        access_token: access_token
      }
      response = get('getPageList', params)
      PageList.new(response)
    end

    def get_views(path:, year: nil, month: nil, day: nil, hour: nil)
      params = { path: path }
      time_params = {
        year: year,
        month: month,
        day: day,
        hour: hour
      }
      params.merge(time_params) if time?(time_params)
      response = get('getViews', params)
      PageViews.new(response)
    end

    private

    def time?(time_params)
      time_params.values.compact.any?
    end
  end
end
