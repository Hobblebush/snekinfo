defmodule SnekinfoWeb.ViewHelpers do
  use Phoenix.HTML
  alias SnekinfoWeb.Router.Helpers, as: Routes

  alias Snekinfo.Snakes.Snake

  import Phoenix.View

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
        {"∅", ""}
      end
    end
  end

  def species_options(species) do
    Enum.map species, fn sp ->
      {sp.name, sp.id}
    end
  end

  def litter_name(nil), do: "∅"
  def litter_name(%Ecto.Association.NotLoaded{}), do: "??"
  def litter_name(litter) do
    if Ecto.assoc_loaded?(litter.mother) do
      "#{to_string(litter.born)} #{litter.mother.name}"
    else
      "BUG: ASSOC MOTHER NOT LOADED"
    end
  end

  def litter_link(_conn, nil), do: "∅"
  def litter_link(_conn, %Ecto.Association.NotLoaded{}), do: "??"
  def litter_link(conn, litter) do
    text = litter_name(litter)
    link(text, to: Routes.litter_path(conn, :show, litter))
  end

  def litter_option(litter) do
    cond do
      is_nil(litter) ->
        {"∅", ""}
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

  def species_link(_conn, %Ecto.Association.NotLoaded{}), do: "??"
  def species_link(conn, species) do
    species.name
    |> String.split()
    |> Enum.at(0)
    |> link(to: Routes.species_path(conn, :show, species))
  end

  def traits_to_json(traits) do
    Enum.map(traits, fn trait ->
      SnekinfoWeb.TraitView.render("trait.json", %{trait: trait})
    end)
    |> Jason.encode!(pretty: true)
  end

  def render_assoc(item, slug) do
    text = to_string(slug)
    view = String.to_atom("Elixir.SnekinfoWeb.#{String.capitalize(text)}View")
    template = "#{text}.json"
    if Ecto.assoc_loaded?(item) do
      render_one(item, view, template)
    else
      nil
    end
  end

  def render_assocs(items, slug) do
    text = to_string(slug)
    view = String.to_atom("Elixir.SnekinfoWeb.#{String.capitalize(text)}View")
    template = "#{text}.json"
    if Ecto.assoc_loaded?(items) do
      render_many(items, view, template)
    else
      nil
    end
  end

  def assoc_field(item, field) do
    if !is_nil(item) && Ecto.assoc_loaded?(item) do
      Map.get(item, field)
    else
      nil
    end
  end

  def snake_active?(snake) do
    Snake.active_status?(snake.status)
  end
end
