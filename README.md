# Performance Talk
## Common Refactorings


## Part 3: Eager To Change

One of the best ways to increase performance is to take a look at our controller and models to identify where queries are taking place. The goal is just to reduce potential queries into earlier queries. This concept is called Eager Loading, because it seeks to load data in the hopes that we'll need it.

### N + 1 Query Problem

See this [link](http://edgeguides.rubyonrails.org/active_record_querying.html#eager-loading-associations) on the definition of the [problem](http://edgeguides.rubyonrails.org/active_record_querying.html#eager-loading-associations).

### `includes`

The key method for included more data in our queries is going to be to use the `includes` method. 

Let's take a look around to see if we see this in our application:


```
class UsersController < ApplicationController
  
  ...

  def show
    @user = User.find_by({id: params[:id]})
    @articles = @user.articles
  end

  ...
end
```

Hmm.. is that all? Let's check out the view.

`users/show.html.erb`

```
<h1>Users#show</h1>
<p>Find me in app/views/users/show.html.erb</p>

<%= @user.first_name %>


<% @articles.each do |article| %>
  <%= render partial: "articles/preview", locals: {article: article }%>
<% end %>

```

We see here that we are rendering each article... let's examine that partial.

`articles/_preview.html.erb`

```

<div>
  <div>
    <h2><%= link_to article.title.titleize, article_path(article) %></h2>
  </div>
  <div>
    <% if article.keywords %>
      <span class="article-keywords"><%= article.keywords %></span>
    <% end %>
  </div>
</div>

```

it looks like we are calling `article.keywords` in our `_preview`. Let's take a look at what that is doing.


`models/article.rb`

```

  def keywords
    unless @keywords
      # makes a request for tags from the db
      words = tags.map {|t| t.text }
      @keywords = words.join(" | ")
    else
      @keywords
    end
  end


```


It looks like our show page has the following list of models being loaded.


```
load User
load User Articles
load Tags Associated to User Articles
```

We could the first two queries into one quite easily

```
class UsersController < ApplicationController
  
  ...

  def show
    # grabs both the user and associated articles
    @user = User.includes(:articles).find_by({id: params[:id]})
    @articles = @user.articles
  end

  ...
end
```

But we know that the `keywords` method also selects the associated `tags`, so we should grab that as well.


```
class UsersController < ApplicationController
  
  ...

  def show
    # grabs both the user and associated articles
    @user = User.includes(:articles => :tags).find_by({id: params[:id]})
    @articles = @user.articles
  end

  ...
end
```
