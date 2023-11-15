defmodule AshTwitter.Support.Registry do
  use Ash.Registry

  entries do
    entry AshTwitter.Support.Tweet
    entry AshTwitter.Support.Comment
    entry AshTwitter.Support.Author
    entry AshTwitter.Support.AuthorLike
  end
end
