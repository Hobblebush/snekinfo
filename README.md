# Snekinfo

## Development setup

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Deployment

Prep (on server):
 
 * Make sure you have a `snekinfo_prod` Postgres database set up on the server.
 * Enable nginx config 
 * Enable systemd service

Build release (on dev box):

 * Run `scripts/release.sh`

Deploy to server:

 * Copy tarball to server and unpack
 * Make sure systemd service is stopped
 * In `snekinfo` directory:
   * Run `scripts/migrate.sh`
   * Run `scripts/server.sh` to test; then kill
 * Start systemd service.
