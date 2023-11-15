alias AshTwitter.Support.Tweet
alias AshTwitter.Support.Author
alias AshTwitter.Support.Comment
alias AshTwitter.Support, as: SupportApi

defmodule IExPopulate do
   require Ash.Query

   def create_author(name, email) do
     Author
     |> Ash.Changeset.for_create(:create, %{name: name, email: email})
     |> SupportApi.create!()
   end

   def create_tweet_for_author(author_id, content) do
   tweet = %{
         content: content,
         author_id: author_id
         }
    Tweet
    |> Ash.Changeset.for_create(:create, tweet)
    |> SupportApi.create!()
   end

   def create_comment_for_tweet(tweet_id, content) do
    Comment
    |> Ash.Changeset.for_create(:create, %{content: content, tweet_id: tweet_id})
    |> SupportApi.create!()
   end

   def populate() do
     # create one user
     author = create_author("Naruto", "naruto@hiddenleaf.com")
     IO.inspect(author)
     # create 5 tweets, 5 comments for each tweet
     for i <- 0..5 do
       tweet_content = "Tweet #{i}"
       tweet = create_tweet_for_author(author.id, tweet_content)
       for i <- 0..2 do
         create_comment_for_tweet(tweet.id, "#{tweet_content} Comment #{i}")
       end
     end
   end
end
