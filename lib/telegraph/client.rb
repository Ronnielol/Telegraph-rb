module Telegraph
  class Client
    include Telegraph::Connection

    attr_reader :token

    def initialize(token)
      @token = token
    end

    def create_account(attrs = {})
      acc_info = get('createAccount', attrs)
      @account = Account.new(acc_info)
    end

    def account
      @account ||= get_account_info
    end

    def get_account_info(*fields)
      # Gets all available account information if 'fields' array not given.
      available_fields = %w(short_name author_name author_url auth_url page_count)
      fields = available_fields if fields.empty?
      response = get('getAccountInfo', fields: fields.to_s)
      Account.new(response)
    end

    def edit_account_info(attrs = {})
      response = get('editAccountInfo', attrs)
      update_account(account, response)
    end

    def create_page(attrs = {})
      response = get('createPage', attrs)
      Page.new(response)
    end

    def get_page(attrs = {})
      response = get('getPage', attrs)
      Page.new(response)
    end

    def get_page_list(attrs = {})
      response = get('getPageList', attrs)
      PageList.new(response)
    end

    def get_views(attrs = {})
      response = get('getViews', attrs)
      PageViews.new(response)
    end

    def revoke_access_token(attrs = {})
      response = get('revokeAccessToken')
      Account.new(response)
    end

    private

    def update_account(account, attrs)
      attrs.each do |k,v|
        account.instance_variable_set("@#{k}", v)
      end
      account
    end
  end
end