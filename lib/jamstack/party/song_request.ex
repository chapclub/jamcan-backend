defmodule Jamstack.Party.SongRequest do
  use Ecto.Schema
  import Ecto.Changeset

  alias Jamstack.JS.Party

  schema "song_requests" do
    field :boo_count, :integer, default: 0
    field :spotify_uri, :string
    field :title, :string
    belongs_to :party, Party

    timestamps()
  end

  @doc false
  def changeset(song_request, attrs) do
    song_request
    |> cast(attrs, [:spotify_uri, :boo_count, :title, :party_id])
    |> cast_assoc(:party)
    |> validate_required([:spotify_uri, :boo_count, :title])
  end
end
