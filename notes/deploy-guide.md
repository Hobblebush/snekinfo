
# Deployment

Here's how to deploy updates to an already working production server.

## Build the release

On your local development machine, from the top level project directory, run the
script to build the release:

```
$ scripts/release.sh
```

This will create a tar archive.

## Deploy to server

From your local dev machine, copy tarball to server:

```
dev-box$ scp [tarball] user@server:~ 
```

Now, you'll want two ssh connections to the server:

 * One as the app user to unpack the tarball and run the migrations.
 * One as an admin user to control the systemd service.

As the app user:

 * Untar the tarball over the existing app directory.
 * cd into the app directory
 * Run `scripts/migrate.sh` if this update includes any DB migrations.

As the admin user:

 * Restart the systemd service: `sudo service snekinfo start`

That should be fully deployed.

## If anything goes wrong

 * Stop the systemd service: `sudo service snekinfo stop`
 * As the app user, from the app directory, run `scripts/server.sh` to see if
   you get any error messages.
