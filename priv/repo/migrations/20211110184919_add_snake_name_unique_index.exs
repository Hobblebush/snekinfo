defmodule Snekinfo.Repo.Migrations.AddSnakeNameUniqueIndex do
  use Ecto.Migration

  def change do
    create index(:snakes, [:name], unique: true)
  end
end
