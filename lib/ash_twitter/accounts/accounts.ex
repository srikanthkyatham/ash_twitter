defmodule AshTwitter.Accounts do
  use Ash.Api

  resources do
    resource AshTwitter.Accounts.User
    resource AshTwitter.Accounts.Token
  end
end
