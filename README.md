# oh-my-zsh in Docker

Installation of a customized dockerized oh-my-zsh (Debian).

[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/aifrak/oh-my-zsh)](https://hub.docker.com/r/aifrak/oh-my-zsh/builds)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/aifrak/oh-my-zsh?color=orange&sort=semver)](https://hub.docker.com/r/aifrak/oh-my-zsh/tags)
[![Docker Pulls](https://img.shields.io/docker/pulls/aifrak/oh-my-zsh?color=yellow)](https://hub.docker.com/r/aifrak/oh-my-zsh/)
[![Dockerfile lint](https://github.com/aifrak/oh-my-zsh-docker/actions/workflows/dockerfile-lint.yml/badge.svg)](https://github.com/aifrak/oh-my-zsh-docker/actions/workflows/dockerfile-lint.yml)
[![Markdown lint](https://github.com/aifrak/oh-my-zsh-docker/actions/workflows/markdown-lint.yml/badge.svg)](https://github.com/aifrak/oh-my-zsh-docker/actions/workflows/markdown-lint.yml)
[![GitHub](https://img.shields.io/github/license/aifrak/oh-my-zsh-docker?color=blue)](https://github.com/aifrak/oh-my-zsh-docker/blob/master/LICENSE)

## How to use this image

```shell
docker run -it --rm aifrak/oh-my-zsh
```

## Docker

```shell
docker pull aifrak/oh-my-zsh
```

## Quick references

- **Docker hub**: <https://hub.docker.com/r/aifrak/oh-my-zsh>
- **Github**: <https://github.com/aifrak/oh-my-zsh-docker>
- **Changelog**: <https://github.com/aifrak/oh-my-zsh-docker/blob/master/CHANGELOG.md>

## Theme

- [powerlevel10k](https://github.com/romkatv/powerlevel10k)

## Fonts

- [Fira Code from Nerd fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)

## Debian packages

- [LSDeluxe](https://github.com/Peltoche/lsd)

## oh-my-zsh plugins

- colored-man-pages
- colorize
- command-not-found
- copyfile
- dirhistory
- extract
- git
- gitstatus
- git-extras
- globalias
- mix
- mix-fast
- [z](https://github.com/agkozak/zsh-z)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-interactive-cd](https://github.com/changyuheng/zsh-interactive-cd) + [fzf](https://github.com/junegunn/fzf)
- [zsh-navigation-tools](https://github.com/psprint/zsh-navigation-tools)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
