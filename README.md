# Telegraph-rb

Telegra.ph API Ruby client
# Usage
Setup existing Telegra.ph account like this:
```ruby
telegraph_client = Telegraph.setup(secret_token)
```
Or create new one:
```ruby
telegraph_account = Telegraph.create_account(short_name: 'Writer O.G')
telegraph_client = telegraph_account.client
```
Now you can use following methods:
### #create_page
```ruby
page_content = [{:tag=>"h1", :children=>["Article Heading"]}
telegraph_client.create_page(
  title: 'My article'
  author_name: 'Writer' 
  author_url: 'http://writer.com'
  content: page_content
)
# => Telegraph::Page(title: 'My article', author_name: 'Writer', author_url: 'http://writer.com')
```
### #edit_page
```ruby
#Not implemented yet
```
### #get_page
```ruby
telegraph_client.get_page('Sample-Page-12-15')
# => Telegraph::Page()
```
### #get_page_list
```ruby
telegrap_client.get_page_list(limit: 1)
# => #<Telegraph::PageList @total_count=0 @pages=[]>
```
### #get_account_info
Retruns Account object with all available fields (short_name, author_name, author_url, auth_url, page_count.)
```ruby
telegraph_client.get_account_info
# => Telegraph::Account @access_token="", @short_name="short name", @author_name="author name ", @auth_url="https://edit.telegra.ph/auth/XXXXXX", @author_url="http://author-url.com/", @page_count=100>
```
### #edit_account_info
```ruby
telegraph_client.edit_account_info(short_name: 'new_name')
# => Telegraph::Account short_name: 'new_name'
```