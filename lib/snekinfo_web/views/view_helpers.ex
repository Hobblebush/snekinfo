defmodule SnekinfoWeb.ViewHelpers do
  use Phoenix.HTML
  alias SnekinfoWeb.Router.Helpers, as: Routes

  def try_get(obj, []), do: obj
  def try_get(obj, [k|ks]) do
    if obj do
      try_get(Map.get(obj, k), ks)
    else
      nil
    end
  end

  def show_snake(_conn, nil), do: "∅"
  def show_snake(conn, snake) do
    if Ecto.assoc_loaded?(snake) do
      link(snake.name, to: Routes.snake_path(conn, :show, snake))
    else
      "BUG: ASSOC NOT LOADED"
    end
  end

  def show_litter(_conn, nil), do: "∅"
  def show_litter(conn, litter) do
    text = if Ecto.assoc_loaded?(litter.mother) do
      "#{to_string(litter.born)} #{litter.mother.name}"
    else
      to_string(litter.born)
    end
    link(text, to: Routes.litter_path(conn, :show, litter))
  end

  def show_traits(conn, traits) do
    if Ecto.assoc_loaded?(traits) do
      xs = Enum.map traits, fn trait ->
        link(trait.name, to: Routes.trait_path(conn, :show, trait))
      end
      Enum.intersperse(xs, ", ")
    else
      "BUG: ASSOC NOT LOADED"
    end
  end
end
