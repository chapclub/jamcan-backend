defmodule Jamstack.JS.Party do
  use Ecto.Schema
  import Ecto.Changeset

  import Ecto.Query, only: [from: 2]

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

  @doc """
  Given a join_code, creates an ecto query to find the party with the given join
  code.
  """
  def query_with_join_code(join_code) do
    from p in __MODULE__,
      where: p.join_code == ^join_code
  end
end
