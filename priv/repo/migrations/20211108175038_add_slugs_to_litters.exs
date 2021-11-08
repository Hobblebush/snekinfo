defmodule Snekinfo.Repo.Migrations.AddSlugsToLitters do
  use Ecto.Migration

  def change do
    alter table("litters") do
      add :slugs, :integer, null: false, default: 0
      add :stills, :integer, null: false, default: 0
    end
  end
end
