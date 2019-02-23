defmodule Jamstack.Repo.Migrations.CreateParties do
  use Ecto.Migration

  def change do
    create table(:parties) do
      add :title, :string
      add :join_code, :string
      add :active, :boolean, default: true, null: false
      add :owner_id, :string

      timestamps()
    end

  end
end
