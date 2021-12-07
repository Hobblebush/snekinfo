defmodule SnekinfoWeb.SpeciesView do
  use SnekinfoWeb, :view

  def render("index.json", %{speciess: speciess}) do
    %{data: render_many(speciess, __MODULE__, "species.json")}
  end

  def render("show.json", %{species: species}) do
    %{data: render_one(species, __MODULE__, "species.json")}
  end

  def render("species.json", %{species: species}) do
    %{
      name: species.name,
      path: Routes.species_path(SnekinfoWeb.Endpoint, :show, species),
    }
  end
end
