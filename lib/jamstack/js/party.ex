defmodule Jamstack.JS.Party do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parties" do
    field :active, :boolean, default: true
    field :auth_token, :string
    field :join_code, :string
    field :refresh_token, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(party, attrs) do
    party
    |> cast(attrs, [:title, :join_code, :active, :auth_token, :refresh_token])
    |> validate_required([:title, :join_code, :active, :auth_token, :refresh_token])
  end
end
