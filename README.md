# Caddy Server on Alpine Linux

Simple Development Proxy for productive full-stack development. 

This is a [Docker](https://www.docker.com/) image for [Caddy](https://caddyserver.com/) web server. This image runs with a base of [Alpine-Linux](http://www.alpinelinux.org/) making it extremely small, secure and fast. 

<img align="right" width="200" src="served-with-caddy-black.png" />

## Requirements

* [Docker](https://www.docker.com/)

## Getting Started

### 1. Setup ".env" file

Create an `.env` file in the root directory of your project. Add environment-specific variables on new lines in the form of `NAME=VALUE`. For example:

```
API_ROOT_1=https://your-api
API_ROOT_2=https://your-other-api
```

That's it.

Docker will pick up the keys and values you defined in your `.env` file.

> **Should I commit my ".env" file?**
>
> No. We **strongly** recommend against committing your `.env` file to version control. It should only include environment-specific values such as database passwords or API keys.

### 2. Run start script

 Run the included ```start.sh``` script to launch the **Caddy** container.

```bash
$ ./start.sh
```

Point your browser to `http://localhost:3000` or `http://localhost:4000`

## Usage

This image works with two defaults

1. A default [Caddyfile](https://github.com/asanchezr/caddy-docker/blob/master/Caddyfile)
2. A default location inside the container for static files (optional): `/var/www/html`

In order to use this image, we recommend running it with a volume connecting your static files to the root location of the docker file:

```bash
$ docker run -d -p 3000:3000 -p 4000:4000 -v $(pwd)/public:/var/www/html alpine-caddy
```

The server will be available at _http://your.docker.machine.ip_

The benefits of building an image with a overrideable Caddyfile are that you can include your own by including another volume.

For writing a custom Caddyfile please read [this](https://caddyserver.com/docs/caddyfile).

#### Default Caddyfile

The image contains a default Caddyfile. It acts as a simple reverse proxy

```
localhost:3000 {
  gzip
  log stdout
  errors stdout
  cors
  root /var/www/html
  proxy /api {$API_ROOT_1} {
    header_upstream Accept-Encoding {>Accept-Encoding}
  }
}

localhost:4000 {
  gzip
  log stdout
  errors stdout
  cors
  root /var/www/html
  proxy /api {$API_ROOT_2} {
    header_upstream Accept-Encoding {>Accept-Encoding}
  }
}
```

It’s possible to use environment variables in your shell to populate values inside a Caddyfile:

* `API_ROOT_1` and `API_ROOT_2` are substituted with values configured in the `.env` file.

## Volumes

Alpine-Caddy has three locations where volumes can be linked to.

### Static Files

In order to serve static content, alpine-caddy needs to be able to access your static files from inside of the container. To do this, link the directory of your static files with /var/www/html inside of the container.

For docker-compose.yml files, under the volumes declaration, include:

```
-  ./public:/var/www/html
```

or

```bash
$ docker run -v $(pwd)/public:/var/www/html
```

### Custom Caddyfile

To upload a custom Caddyfile, link your Caddyfile to the directory /etc/Caddyfile in the container.
For docker-compose.yml files, under the volumes declaration, include:

```
-  ./Caddyfile:/etc/Caddyfile
```

or

```bash
    docker run -v $(pwd)/Caddyfile:/etc/Caddyfile alpine-caddy
```
