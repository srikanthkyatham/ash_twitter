defmodule AshTwitterWeb.Support.Router do
  use AshJsonApi.Api.Router,
    apis: [AshTwitter.Support],
    json_schema: "/json_schema",
    open_api: "/open_api"
end
