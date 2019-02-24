defmodule Jamstack.Repo.Migrations.CreateSongRequests do
  use Ecto.Migration

  def change do
    create table(:song_requests) do
      add :spotify_uri, :string
      add :boo_count, :integer
      add :title, :string
      add :party_id, references(:parties, on_delete: :delete_all)

      timestamps()
    end

    create index(:song_requests, [:party_id])
  end
end
