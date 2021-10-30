defmodule Snekinfo.Repo.Migrations.CreateSnakeTraits do
  use Ecto.Migration

  def change do
    create table(:snake_traits) do
      add :snake_id, references(:snakes, on_delete: :delete_all), null: false
      add :trait_id, references(:traits, on_delete: :restrict), null: false
    end

    create index(:snake_traits, [:snake_id])
    create index(:snake_traits, [:trait_id])
    create index(:snake_traits, [:snake_id, :trait_id], unique: true)
  end
end
