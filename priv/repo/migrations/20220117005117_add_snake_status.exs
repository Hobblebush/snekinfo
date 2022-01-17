defmodule Snekinfo.Repo.Migrations.AddSnakeStatus do
  use Ecto.Migration

  def change do
    alter table("snakes") do
      add :status, :string, null: false, default: "keep"
      add :price, :decimal
      add :notes, :text
    end
  end
end
