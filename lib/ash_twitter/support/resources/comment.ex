defmodule AshTwitter.Support.Comment do
  # This turns this module into a resource
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  alias AshTwitter.Support.Tweet
  alias AshTwitter.Support

  postgres do
    table "comments"
    repo AshTwitter.Repo
  end

  actions do
    # Add a set of simple actions. You'll customize these later.
    defaults [:create, :read, :update, :destroy]
  end

  # Attributes are the simple pieces of data that exist on your resource
  attributes do
    # Add an autogenerated UUID primary key called `:id`.
    uuid_primary_key :id

    # Add a string type attribute called `:subject`
    attribute :content, :string
  end

  relationships do
    belongs_to :tweet, Tweet do
      api Support
      allow_nil? false
    end
  end

end
