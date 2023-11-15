defmodule AshTwitter.Support.AuthorLike do
  # This turns this module into a resource
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  alias AshTwitter.Support, as: SupportApi
  alias AshTwitter.Support.Author
  alias AshTwitter.Support.Tweet

  postgres do
    table "likes"
    repo AshTwitter.Repo
  end

  actions do
    # Add a set of simple actions. You'll customize these later.
    defaults [:create, :read, :update, :destroy]

    create :like do
      upsert? true
    end
  end

  relationships do
    belongs_to :author, Author do
      primary_key? true
      allow_nil? false
      attribute_writable? true
      attribute_type :uuid
    end

    belongs_to :tweet, Tweet do
      primary_key? true
      allow_nil? false
      attribute_writable? true
      attribute_type :uuid
    end
  end

  code_interface do
    define_for SupportApi
    define :like, args: [:author_id, :tweet_id]
  end
end
