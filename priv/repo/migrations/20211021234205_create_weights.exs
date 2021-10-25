defmodule Snekinfo.Repo.Migrations.CreateWeights do
  use Ecto.Migration

  def change do
    create table(:weights) do
      add :weight, :float, null: false
      add :timestamp, :utc_datetime, null: false
      add :snake_id, references(:snakes, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:weights, [:snake_id])
  end
end
