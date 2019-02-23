defmodule Jamstack.JS.Party do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parties" do
    field :active, :boolean, default: true
    field :join_code, :string
    field :title, :string
    field :owner_id, :string

    timestamps()
  end

  @doc false
  def changeset(party, attrs) do
    party
    |> cast(attrs, [:title, :join_code, :active, :owner_id])
    |> validate_required([:title, :join_code, :active, :owner_id])
  end
end
