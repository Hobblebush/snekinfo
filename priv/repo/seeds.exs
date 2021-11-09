# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Snekinfo.Repo.insert!(%Snekinfo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Ecto.Changeset

alias Snekinfo.Repo
alias Snekinfo.Feeds
alias Snekinfo.Feeds.Feed
alias Snekinfo.Litters
alias Snekinfo.Litters.Litter
alias Snekinfo.Snakes
alias Snekinfo.Snakes.Snake
alias Snekinfo.Traits
alias Snekinfo.Traits.Trait
alias Snekinfo.Weights.Weight
alias Snekinfo.Taxa
alias Snekinfo.Taxa.Species

defmodule Make do
  def snake!(attrs) do
    snake = if attrs[:litter] do
      struct(Snake, Map.put(attrs, :born, attrs.litter.born))
    else
      struct(Snake, attrs)
    end

    item = Repo.insert!(snake)
    traits = attrs[:traits] || []

    item
    |> Repo.preload(:traits)
    |> Changeset.change()
    |> Changeset.put_assoc(:traits, traits)
    |> Repo.update!()
  end
end

ksb = Taxa.get_or_create_species("Kenyan Sand Boa")
rsb = Taxa.get_or_create_species("Russian Sand Boa")

splash = Repo.insert!(%Trait{name: "splash", inheritance: "recessive",
                            species_id: ksb.id})
paint = Repo.insert!(%Trait{name: "paint", inheritance: "dominant",
                            species_id: ksb.id})
flying = Repo.insert!(%Trait{name: "flying", inheritance: "poly",
                            species_id: ksb.id})
evil = Repo.insert!(%Trait{name: "evil", inheritance: "dominant",
                            species_id: ksb.id})

alice = Make.snake!(%{name: "Alice", sex: "F", born: ~D[2019-03-06],
                      traits: [splash, flying], species_id: ksb.id })
bob = Make.snake!(%{name: "Bob", sex: "M", born: ~D[2019-02-19],
                    traits: [flying], species_id: ksb.id})

litter1 = Repo.insert!(%Litter{born: ~D[2020-09-24], mother_id: alice.id, father_id: nil})
litter2 = Repo.insert!(%Litter{born: ~D[2021-07-03], mother_id: alice.id, father_id: bob.id})

carol = Make.snake!(%{name: "Carol", sex: "F", litter: litter1, traits: [evil, splash]})
dave = Make.snake!(%{name: "Dave", sex: "M", litter: litter1, traits: [flying]})

eve = Make.snake!(%{name: "Eve", sex: "F", litter: litter2, traits: []})
frank = Make.snake!(%{name: "Frank", sex: "M", litter: litter2, traits: [flying, splash]})

Repo.insert!(%Weight{snake_id: alice.id, date: ~D[2021-08-15], weight: 200.0})
Repo.insert!(%Weight{snake_id: alice.id, date: ~D[2021-09-15], weight: 210.0})

Repo.insert!(%Feed{snake_id: alice.id, date: ~D[2021-08-15], live?: false,
                   weight: 20.7, ingested?: false})
Repo.insert!(%Feed{snake_id: alice.id, date: ~D[2021-08-21], live?: true,
                   weight: 23.4, ingested?: true})
Repo.insert!(%Feed{snake_id: alice.id, date: ~D[2021-09-15], live?: true,
                   weight: 18.0, ingested?: true})
