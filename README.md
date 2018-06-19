# Caddy Server on Alpine Linux

Simple Development Proxy for productive full-stack development. 

This is a [Docker](https://www.docker.com/) image for [Caddy](https://caddyserver.com/) web server. This image runs with a base of [Alpine-Linux](http://www.alpinelinux.org/) making it extremely small, secure and fast. 

<img align="right" width="200" src="served-with-caddy-black.png" />

## Requirements

* Docker

## Getting Started

### 1. Setup ".env" file

Create a `.env` file in the root directory of your project. Add environment-specific variables on new lines in the form of `NAME=VALUE`. For example: 

```
API_ROOT_1=https://your-api
API_ROOT_2=https://your-other-api
```

That's it. 

Docker will pick up the keys and values you defined in your `.env` file. 

> **Should I commit my ".env" file?**
>
> No. We **strongly** recommend against committing your `.env` file to version control. It should only include environment-specific values such as database passwords or API keys. 

### 2. Run start.sh

 Run the included ```start.sh``` script to launch the **Caddy** container. 

```bash
$ ./start.sh
```

Point your browser to `http://localhost:3000` or `http://localhost:4000`

## Usage

This image works with two defaults

1. A default [Caddyfile](https://github.com/asanchezr/caddy-docker/blob/master/Caddyfile)
2. A default location inside the container for static files (optional): `/var/www/html`

#### Default Caddyfile

The image contains a default Caddyfile. It acts as a simple reverse proxy 

```
localhost:3000 {
  log stdout
  errors stdout
  cors
  proxy / {$API_ROOT_1}
}

localhost:4000 {
  log stdout
  errors stdout
  cors
  proxy / {$API_ROOT_2}
}
```

It’s possible to use environment variables in your shell to populate values inside a Caddyfile: 

* `API_ROOT_1` and `API_ROOT_2` are substituted with values configured in the `.env` file.

