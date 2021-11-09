defmodule Snekinfo.Repo.Migrations.AddSpeciesToSnakesAndTraits do
  use Ecto.Migration

  alias Snekinfo.Repo
  alias Snekinfo.Taxa

  def change do
    ksb = Taxa.get_or_create_species("Kenyan Sand Boa")

    alter table(:snakes) do
      add :species_id, references(:species, on_delete: :nothing),
        null: false, default: ksb.id
    end

    alter table(:traits) do
      add :species_id, references(:species, on_delete: :nothing),
        null: false, default: ksb.id
    end

    create index("snakes", [:species_id])
    create index("traits", [:species_id])
  end
end
