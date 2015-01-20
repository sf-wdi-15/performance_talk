# Performance Cont.
## Common Performance Refactors

## Part 5: All About Indexes

* [postgres: what is an index](http://www.postgresql.org/docs/9.4/static/indexes.html)
  * [What is a hash](http://en.wikipedia.org/wiki/Hash_table)
  * [What is a b-tree](http://en.wikipedia.org/wiki/B-tree)
    * [What is a heap](http://en.wikipedia.org/wiki/Heap_%28data_structure%29)
* [add_index](http://apidock.com/rails/ActiveRecord/ConnectionAdapters/SchemaStatements/add_index)
* [What is a constraint](http://www.postgresql.org/docs/9.4/static/ddl-constraints.html)
  * [Rails Migration Foriegn Keys](http://guides.rubyonrails.org/active_record_migrations.html#foreign-keys)


## Part 5: Adding An Index

To add an `index` we need to generate a migration `AddIndexToArticles`


```
rails g migration AddIndexToArticles
```

`db/migrate/...add_index_to_articles.rb`

```
  def change
    add_index :articles, :user_id
    add_foreign_key :articles, :users
  end
```
