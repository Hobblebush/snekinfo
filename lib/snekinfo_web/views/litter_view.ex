defmodule SnekinfoWeb.LitterView do
  use SnekinfoWeb, :view

  def render("index.json", %{litters: litters}) do
    %{data: render_many(litters, LitterView, "litter.json")}
  end

  def render("show.json", %{litter: litter}) do
    %{data: render_one(litter, LitterView, "litter.json")}
  end

  def render("litter.json", %{litter: litter}) do
    %{
      name: litter_name(litter),
      path: Routes.litter_path(SnekinfoWeb.Endpoint, :show, litter),
    }
  end
end
