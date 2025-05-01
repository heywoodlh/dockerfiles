This image provides a built-from-source version of [lnav](https://github.com/tstack/lnav)

The Dockerfile and build resources for this image are here: [github.com/heywoodlh/dockerfiles: lnav](https://github.com/heywoodlh/dockerfiles/tree/master/lnav)

The GitHub Action used to build this image is here: [lnav-buildx.yaml](https://github.com/heywoodlh/actions/blob/master/.github/workflows/lnav-buildx.yml)

## Builder image

To build and test using the latest version of the builder image locally _without pushing_, run the following:

```
FRESH_BUILDER=true ./build.sh
```

Run the following to build _and push_ the builder image:

```
FRESH_BUILDER=true PUSH=true ./build.sh
```
