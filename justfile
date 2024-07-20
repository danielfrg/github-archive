default:
  just --list

backup:
  ./backup.sh

docker-build:
  docker build -t ghcr.io/danielfrg/github-archive .

docker-run:
  docker run -it --rm -e GH_TOKEN=$GH_TOKEN -v $PWD/data:/data ghcr.io/danielfrg/github-archive
