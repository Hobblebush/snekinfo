defmodule SnekinfoWeb.WeightView do
  use SnekinfoWeb, :view

  def render("index.json", %{weights: weights}) do
    %{data: render_many(weights, WeightView, "weight.json")}
  end

  def render("show.json", %{weight: weight}) do
    %{data: render_one(weight, WeightView, "weight.json")}
  end

  def render("weight.json", %{weight: weight}) do
    %{
      id: weight.id,
      date: weight.date,
      weight: weight.weight,
      snake: render_assoc(weight.snake, :snake),
      path: Routes.weight_path(SnekinfoWeb.Endpoint, :show, weight),
    }
  end
end
