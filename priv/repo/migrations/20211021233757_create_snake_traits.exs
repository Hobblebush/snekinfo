defmodule Snekinfo.Repo.Migrations.CreateSnakeTraits do
  use Ecto.Migration

  def change do
    create table(:snake_traits) do
      add :snake_id, references(:snakes, on_delete: :nothing), null: false
      add :trait_id, references(:traits, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:snake_traits, [:snake_id])
    create index(:snake_traits, [:trait_id])
  end
end
