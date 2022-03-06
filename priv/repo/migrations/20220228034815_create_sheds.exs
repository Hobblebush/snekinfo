defmodule Snekinfo.Repo.Migrations.CreateSheds do
  use Ecto.Migration

  def change do
    create table(:sheds) do
      add :date, :date, null: false
      add :snake_id, references(:snakes, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:sheds, [:snake_id])
  end
end
