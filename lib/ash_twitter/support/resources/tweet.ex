defmodule AshTwitter.Support.Tweet do
  # This turns this module into a resource
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJsonApi.Resource]

  alias AshTwitter.Support
  alias AshTwitter.Support.Author
  alias AshTwitter.Support.AuthorLike
  alias AshTwitter.Repo
  import Ecto.Query, only: [from: 2]

  json_api do
    type "tweet"

    routes do
      base "/tweets"

      get :read
      index :read
      post :create
    end
  end

  postgres do
    table "tweets"
    repo AshTwitter.Repo
  end

  actions do
    # Add a set of simple actions. You'll customize these later.
    defaults [:read, :update]

    create :create do
      primary?(true)

      argument :author_id, :uuid do
        allow_nil?(false)
      end

      change(set_attribute(:author_id, arg(:author_id)))
    end

    destroy :destroy do
      primary? true

      change before_action(fn changeset ->
               %{data: tweet_record} = changeset
               tweet_id = tweet_record.id

               delete_fn = fn table_name ->
                 to_delete =
                   from join_tweet in table_name,
                     where: join_tweet.tweet_id == ^tweet_id

                 Repo.delete_all(to_delete)
               end

               # deleting all records for matching service_id in the join tables
               delete_fn.(AuthorLike)

               changeset
             end)
    end


    # like from a friend
  end

  # Attributes are the simple pieces of data that exist on your resource
  attributes do
    # Add an autogenerated UUID primary key called `:id`.
    uuid_primary_key :id

    attribute :content, :string
  end

  relationships do
    belongs_to :author, Author do
      api Support
      allow_nil? false
    end

    many_to_many :likes, Author do
      through AuthorLike
      join_relationship :author_likes
      source_attribute_on_join_resource :tweet_id
      destination_attribute_on_join_resource :author_id
    end
  end


end
