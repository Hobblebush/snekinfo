defmodule Snekinfo.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :approved?, :boolean, default: false, null: false
      add :body, :text, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :snake_id, references(:snakes, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:comments, [:user_id])
    create index(:comments, [:snake_id])
  end
end
