<h1 align="center">V.C.S.P.G.</h1>

<h2 align="center">The vim color scheme preview generator</h2>

### Requirements

- [local docker](https://docs.docker.com/desktop/)

### Get started

> Note: this is still a prototype in _VERY_ early stages

First, clone and `cd` into the root of the repository.

Then, build the docker image

```shell
docker build -t vcspg .
```

Once built, run the image in interactive mode.

```shell
docker run -it vcspg
```

Once in the linux instance, generate data for any color scheme using its name and GitHub owner name.

Example:

```shell
sh generate_color_scheme_data.sh tomasr molokai
```

The output data is stored in `data.json`
