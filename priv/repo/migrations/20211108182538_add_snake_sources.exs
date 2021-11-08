defmodule Snekinfo.Repo.Migrations.AddSnakeSources do
  use Ecto.Migration

  def change do
    alter table("snakes") do
      add :produced_by, :string
      add :cost, :decimal, precision: 10, scale: 2
    end

  end
end
