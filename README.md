# ruby-build mmtk

This repo contains a [ruby-build](https://github.com/rbenv/ruby-build)
definition file for a development version of Ruby compiled with
[MMTk](https://www.mmtk.io/) enabled.

## Instructions

Test locally with [podman](https://podman.io/). The `Containerfile` in
this repo will use `ruby-build` to build the `ruby-mmtk-trunk`
definition inside a container image.

```
podman build .
podman run -it <imageid-from-build>
```