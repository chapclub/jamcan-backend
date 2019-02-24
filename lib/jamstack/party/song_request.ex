defmodule Jamstack.Party.SongRequest do
  use Ecto.Schema
  import Ecto.Changeset


  schema "song_requests" do
    field :boo_count, :integer
    field :spotify_uri, :string
    field :party, :id

    timestamps()
  end

  @doc false
  def changeset(song_request, attrs) do
    song_request
    |> cast(attrs, [:spotify_uri, :boo_count])
    |> validate_required([:spotify_uri, :boo_count])
  end
end
