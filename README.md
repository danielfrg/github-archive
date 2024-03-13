# github-archive

The simplest script to make an archive of all repos in a Github user/org.

Depends on: `gh` and `jq`.

- [one file script](./backup.sh)
- [docker image](https://github.com/danielfrg/github-archive/pkgs/container/github-archive)
  - Auth using a Github Personal Access Token (PAT)
- [kubernetes cronjob template](k8s/cronjob.yml)
- [Github Action template](./.github/workflows/demo-archive.yml)

See the `backup.sh` and `Dockerfile` files for variables.

I use this to run a daily backup on my homelab.

## Usage

Local:

```console
./backup.sh
```

Docker:

```console
export GH_TOKEN=...
docker run -it --rm -e GH_TOKEN=$GH_TOKEN -v $PWD/data:/data ghcr.io/danielfrg/github-archive:main
```

