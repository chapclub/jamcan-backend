defmodule Jamstack.Repo do
  use Ecto.Repo,
    otp_app: :jamstack,
    adapter: Ecto.Adapters.Postgres
end
