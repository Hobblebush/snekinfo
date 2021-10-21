defmodule Snekinfo.Repo.Migrations.CreateLitters do
  use Ecto.Migration

  def change do
    create table(:litters) do
      add :born, :date, null: false
      add :mother_id, references(:snakes, on_delete: :nothing), null: false
      add :father_id, references(:snakes, on_delete: :nothing)

      timestamps()
    end

    create index(:litters, [:mother_id])
    create index(:litters, [:father_id])
  end
end
