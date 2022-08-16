defmodule SnekinfoWeb.TraitView do
  use SnekinfoWeb, :view

  def render("index.json", %{traits: traits}) do
    %{data: render_many(traits, TraitView, "trait.json")}
  end

  def render("show.json", %{trait: trait}) do
    %{data: render_one(trait, TraitView, "trait.json")}
  end

  def render("trait.json", %{trait: trait}) do
    %{
      id: trait.id,
      name: trait.name,
      inheritance: trait.inheritance,
      species_id: trait.species_id,
      path: Routes.trait_path(SnekinfoWeb.Endpoint, :show, trait),
    }
  end

  def sort_traits(xs) do
    Enum.sort_by(xs, &trait_order/1)
  end

  def trait_order(trait) do
    cond do
      trait.name =~ ~r/^het/i -> {5, trait.name}
      trait.name =~ ~r/^ph/i  -> {7, trait.name}
      true -> {3, trait.name}
    end
  end
end
