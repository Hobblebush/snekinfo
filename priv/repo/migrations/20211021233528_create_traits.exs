defmodule Snekinfo.Repo.Migrations.CreateTraits do
  use Ecto.Migration

  def change do
    create table(:traits) do
      add :name, :string, null: false
      add :inheritance, :string, null: false

      timestamps()
    end

    create index("traits", [:name], unique: true)
  end
end
