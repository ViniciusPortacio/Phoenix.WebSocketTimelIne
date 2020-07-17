defmodule Tt.Repo do
  use Ecto.Repo,
    otp_app: :tt,
    adapter: Ecto.Adapters.Postgres
end
