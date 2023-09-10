# github-archive

Simple script and Docker image to create an archive of all repositories in a
GitHub organization.

- Uses a Github Token to authenticate
- I use this to run a weekly backup on my homelab to a NAS
- See the kubernetes [cronjob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) for an example of how to run this on a schedule

## Usage

Local:

```console
# Local
./script/backup.sh
```

Docker

```console
export GH_TOKEN=...
docker run -it --rm -e GH_TOKEN=$GH_TOKEN -v $PWD/data:/data ghcr.io/danielfrg/github-archive:main
```

See the `scripts/backup.sh` and `Dockerfile` script for configuration options.
