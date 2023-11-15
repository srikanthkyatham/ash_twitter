defmodule AshTwitter.Repo do
  use AshPostgres.Repo,
    otp_app: :ash_twitter

  def installed_extensions do
    ["uuid-ossp", "citext"]
  end
end
