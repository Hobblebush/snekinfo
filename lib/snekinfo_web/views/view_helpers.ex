defmodule SnekinfoWeb.ViewHelpers do
  use Phoenix.HTML
  alias SnekinfoWeb.Router.Helpers, as: Routes

  def snake_link(_conn, nil), do: "∅"
  def snake_link(conn, snake) do
    if Ecto.assoc_loaded?(snake) do
      link(snake.name, to: Routes.snake_path(conn, :show, snake))
    else
      "BUG: ASSOC SNAKE NOT LOADED"
    end
  end

  def snake_options(snakes) do
    Enum.map snakes, fn snake ->
      if snake do
        {snake.name, snake.id}
      else
        {"[none]", ""}
      end
    end
  end

  def litter_link(_conn, nil), do: "∅"
  def litter_link(conn, litter) do
    text = if Ecto.assoc_loaded?(litter.mother) do
      "#{to_string(litter.born)} #{litter.mother.name}"
    else
      "BUG: ASSOC MOTHER NOT LOADED"
    end
    link(text, to: Routes.litter_path(conn, :show, litter))
  end

  def litter_option(litter) do
    cond do
      is_nil(litter) ->
        {"[none]", ""}
      Ecto.assoc_loaded?(litter.mother) ->
        {"#{to_string(litter.born)} #{litter.mother.name}", litter.id}
      true ->
        {"BUG: ASSOC MOTHER NOT LOADED", litter.id}
    end
  end

  def trait_links(conn, traits) do
    if Ecto.assoc_loaded?(traits) do
      xs = Enum.map traits, fn trait ->
        link(trait.name, to: Routes.trait_path(conn, :show, trait))
      end
      Enum.intersperse(xs, ", ")
    else
      "BUG: ASSOC TRAITS NOT LOADED"
    end
  end

  def trait_option(trait) do
    {trait.name, trait.id}
  end

  def multi_select(form, field, options, selected, opts) do
    opts = opts
    |> Keyword.put_new(:id, input_id(form, field))
    |> Keyword.put_new(:name, input_name(form, field) <> "[]")
    |> Keyword.put_new(:multiple, "multiple")
    content_tag(:select, options_for_select(options, selected), opts)
  end
end
