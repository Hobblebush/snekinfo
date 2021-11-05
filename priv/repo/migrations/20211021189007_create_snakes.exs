defmodule Snekinfo.Repo.Migrations.CreateSnakes do
  use Ecto.Migration

  def change do
    create table(:snakes) do
      add :name, :string, null: false
      add :sex, :string, null: false
      add :born, :date 

      timestamps()
    end
  end
end
