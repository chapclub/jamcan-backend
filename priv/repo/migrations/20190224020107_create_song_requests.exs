defmodule Jamstack.Repo.Migrations.CreateSongRequests do
  use Ecto.Migration

  def change do
    create table(:song_requests) do
      add :spotify_uri, :string
      add :boo_count, :integer
      add :party, references(:parties, on_delete: :nothing)

      timestamps()
    end

    create index(:song_requests, [:party])
  end
end
