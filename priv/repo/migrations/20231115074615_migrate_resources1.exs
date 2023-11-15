defmodule AshTwitter.Repo.Migrations.MigrateResources1 do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:tweets, primary_key: false) do
      add :id, :uuid, null: false, primary_key: true
      add :content, :text
      add :author_id, :uuid, null: false
    end

    create table(:comments, primary_key: false) do
      add :id, :uuid, null: false, primary_key: true
      add :content, :text

      add :tweet_id,
          references(:tweets,
            column: :id,
            name: "comments_tweet_id_fkey",
            type: :uuid,
            prefix: "public"
          ),
          null: false
    end

    create table(:authors, primary_key: false) do
      add :id, :uuid, null: false, primary_key: true
    end

    alter table(:tweets) do
      modify :author_id,
             references(:authors,
               column: :id,
               name: "tweets_author_id_fkey",
               type: :uuid,
               prefix: "public"
             )
    end

    alter table(:authors) do
      add :name, :text
      add :email, :text
    end
  end

  def down do
    alter table(:authors) do
      remove :email
      remove :name
    end

    drop constraint(:tweets, "tweets_author_id_fkey")

    alter table(:tweets) do
      modify :author_id, :uuid
    end

    drop table(:authors)

    drop constraint(:comments, "comments_tweet_id_fkey")

    drop table(:comments)

    drop table(:tweets)
  end
end