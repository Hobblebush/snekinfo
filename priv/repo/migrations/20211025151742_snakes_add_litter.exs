defmodule Snekinfo.Repo.Migrations.SnakesAddLitter do
  use Ecto.Migration

  def change do
    alter table("snakes") do
      add :litter_id, references(:litters, on_delete: :nothing)
    end

  end
end
