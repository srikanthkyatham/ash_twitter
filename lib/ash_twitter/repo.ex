defmodule AshTwitter.Repo do
  use Ecto.Repo,
    otp_app: :ash_twitter,
    adapter: Ecto.Adapters.Postgres
end
