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

Once built, run the image like an executable by giving it 2 parameters.

```shell
docker run vcspg <github_owner_name> <github_name>
```

Example:

```shell
docker run vcspg morhetz gruvbox
```

There is a third optional parameter which is the name of the color scheme needed for the vim configuration.

Example:

```shell
docker run vcspg NLKNguyen papercolor-theme PaperColor
```

This would add the line `colorscheme PaperColor` to the `.vimrc`. By default, the second parameter is used.
