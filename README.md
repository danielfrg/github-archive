# github-archive

Simple script and Docker image to create an archive of all repositories in a
GitHub organization.

- Uses a Github Token to authenticate
- I use this to run a weekly backup on my homelab to a NAS
- See the kubernetes [cronjob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) for an example of how to run this on a schedule

## Usage

```console
# Local
./script/backup.sh

# Docker
export GH_TOKEN=...
task docker:build
task docker:run
```

See the `scripts/backup.sh` and `Dockerfile` script for configuration options.
