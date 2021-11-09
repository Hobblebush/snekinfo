defmodule Snekinfo.Repo.Migrations.CreateSpecies do
  use Ecto.Migration

  def change do
    create table(:species) do
      add :name, :string, null: false

      timestamps()
    end

    create index("species", [:name], unique: true)
  end
end
