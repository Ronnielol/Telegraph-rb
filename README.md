# Telegraph-rb

Telegra.ph API Ruby client.
# Usage
Setup existing Telegra.ph account like this:
```ruby
client = Telegraph.setup(secret_token)
```
Or create a new one:
```ruby
account = Telegraph.create_account(short_name: 'Writer O.G')
```
After setup you can use following methods:
## Page
### .create
https://telegra.ph/api#createPage
```ruby
page_content = [{:tag=>"h1", :children=>["Article Heading"]}
Page.create(
  title: 'My article'
  author_name: 'Writer'
  author_url: 'http://writer.com'
  content: page_content
)
# => Telegraph::Page(title: 'My article', author_name: 'Writer', author_url: 'http://writer.com')
```
To easily prepare content for a page you can use `Telegraph::NodeConverter` module:
```ruby
class NodeToTelegraph
 extend Telegraph::HTMLConverter

  def self.perform(nokogiri_node)
    node_to_content(nokogiri_node)
  end
end

html = "<p>Lorem ipsum dolor sit <b>amet</b>"
content = NodeToTelegraph.perform(html)
Page.create(title: 'My Article', content: content)
```
### .get
https://telegra.ph/api#getPage
```ruby
page = Page.get(path: 'my-article-12-15')
page.title
#=> My Article
```
### .get_views
https://telegra.ph/api#getViews
```ruby
Page.get_views(path: 'my-article-12-15', year: 2019)
#=> 33
```
### #edit
https://telegra.ph/api#editPage
```ruby
page = Page.get(path: 'my-article-12-15')
content = page.content
page.edit(title: 'New Article Title', content: content)
```
## Account
### .create
Creates account without setupping the client
https://telegra.ph/api#createAccount
```ruby
account = Account.create(short_name: 'Writer O.G')
account.client
#=> nil
```
### .get
https://telegra.ph/api#getAccountInfo
```ruby
account = Account.get
account.short_name = 'Short Name'
```
### #edit
https://telegra.ph/api#editAccountInfo
```ruby
account = Account.get
account.edit(short_name: 'New Short Name')
```
### #get_pages
https://telegra.ph/api#getPageList
```ruby
account.get_pages
#=> [Telegraph::Page, Telegraph::Page]
```
