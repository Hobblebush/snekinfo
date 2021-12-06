defmodule SnekinfoWeb.SnakeView do
  use SnekinfoWeb, :view

  def to_data(snakes) when is_list(snakes) do
    Enum.map(snakes, &to_data/1)
  end

  def to_data(snake) do
    %{
      id: snake.id,
      born: snake.born,
      cost: snake.cost,
      feeds: render_assocs(snake.feeds, :feed),
      litter_id: snake.litter_id,
      litter: render_assoc(snake.litter, :litter),
      name: snake.name,
      produced_by: snake.produced_by,
      sex: snake.sex,
      species_id: snake.species_id,
      species: render_assoc(snake.species, :species),
      traits: render_assocs(snake.traits, :trait),
      updated_at: snake.updated_at,
      weights: render_assocs(snake.weights, :weight),
      path: Routes.snake_path(SnekinfoWeb.Endpoint, :show, snake),
    }
  end

  def render("index.json", %{snakes: snakes}) do
    %{data: render_many(snakes, __MODULE__, "snake.json")}
  end

  def render("show.json", %{snake: snake}) do
    %{data: render_one(snake, __MODULE__, "snake.json")}
  end

  def render("snake.json", %{snake: snake}) do
    to_data(snake)
  end
end
