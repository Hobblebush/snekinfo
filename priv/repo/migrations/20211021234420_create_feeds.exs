defmodule Snekinfo.Repo.Migrations.CreateFeeds do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      add :live?, :boolean, default: false, null: false
      add :weight, :float
      add :ingested?, :boolean, default: false, null: false
      add :date, :date, null: false
      add :snake_id, references(:snakes, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:feeds, [:snake_id])
  end
end
