# Performance Talk
## Common Refactorings


## Part 4: Joining The Conversation

[joins_lesson](joins_lessons/README.md)

## Part 4: Using Joins With ActiveRecord

Earlier we used the `includes` to EagerLoad our associated data for a user. This produced a nice query that went ahead and selected the relevant data we needed.

```
  > User.includes(:articles => :tags).find(1)
  User Load (1.0ms)  SELECT  "users".* FROM "users"  WHERE "users"."id" = $1 LIMIT 1  [["id", 1]]
  Article Load (4.6ms)  SELECT "articles".* FROM "articles"  WHERE "articles"."user_id" IN (1)
  ArticleTag Load (1.3ms)  SELECT "article_tags".* FROM "article_tags"  WHERE "article_tags"."article_id" IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1002)
  Tag Load (1.0ms)  SELECT "tags".* FROM "tags"  WHERE "tags"."id" IN (11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
```

However we know from our knowledge of joins that we could use a join here, and ActiveRecord gives us a nice interface for just that. By default the `.joins` method will always execute an inner join.

```
> user =  User.joins(:articles).find(1)

```

However, notice that unlike the includes statement the `joins` method in AR didn't eagerly load our articles

```
> x = User.joins(:articles).find(1)
  User Load (0.7ms)  SELECT  "users".* FROM "users" INNER JOIN "articles" ON "articles"."user_id" = "users"."id" WHERE "users"."id" = $1 LIMIT 1  [["id", 1]]
 => #<User id: 1, email: "1liam@mohr.biz", first_name: "Dameon", last_name: "Deckow", password_digest: "$2a$10$0pzWW2ettXEiNe2XHhdlrOAWbITLpkPakWQnQ8/pdTz...", created_at: "2015-01-20 03:14:12", updated_at: "2015-01-20 03:14:12"> 

```

Though if we wanted to we could force our original call to `includes` to use a join 

```
> User.includes(:articles).references(:articles).find(1)

```

An okay join for AR might be in the other direction where there is one `user` per article.


```
> Article.joins(:user).select("articles.*, users.first_name as user_name").find(1)
```


This is just the beginnig of using the following QueryMethods

[AR QueryMethods](http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-joins)
