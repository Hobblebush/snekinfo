defmodule Snekinfo.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :filename, :string, null: false
      add :caption, :string
      add :order, :integer, null: false, default: 10
      add :snake_id, references(:snakes, on_delete: :nothing)

      timestamps()
    end

    create index(:photos, [:snake_id])
  end
end
