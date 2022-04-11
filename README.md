# Snekinfo

## Development setup

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Production setup

Prep (on server):
 
 * Make sure you have a `snekinfo_prod` Postgres database set up on the server.
 * Enable nginx config 
 * Enable systemd service

See [the deployment guide](notes/deploy-guide.md) for how to deploy changes.

## Public Views

Don't show:

 - Dead snakes
 - Cost
 - Notes
 - Hide weight for feeds

