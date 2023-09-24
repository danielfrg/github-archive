# github-archive

Simple bash script with just `gh` ahd `jq` as dependencies to create an archive
of all repositories in a GitHub organization.

- I use this to run a daily backup on my homelab
- Includes Docker image + [kubernetes cronjob template](k8s/cronjob.yml)
  - Docker image uses a Github Token to authenticate

## Usage

Local:

```console
./scripts/backup.sh
```

Docker:

```console
export GH_TOKEN=...
docker run -it --rm -e GH_TOKEN=$GH_TOKEN -v $PWD/data:/data ghcr.io/danielfrg/github-archive:main
```

See the `scripts/backup.sh` and `Dockerfile` script for variables.
