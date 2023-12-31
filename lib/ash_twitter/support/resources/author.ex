defmodule AshTwitter.Support.Author do
  # This turns this module into a resource
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJsonApi.Resource]

  alias AshTwitter.Support.Tweet


  json_api do
    type "author"

    routes do
      base "/authors"

      get :read
      index :read
      post :create
    end
  end


  postgres do
    table "authors"
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
    attribute :name, :string
    attribute :email, :string
  end

  relationships do
    has_many :tweets, Tweet
  end
end
