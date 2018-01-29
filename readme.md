# ![RealWorld Example App](logo.png)

> ### Swift (Vapor) codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the [RealWorld](https://github.com/gothinkster/realworld) spec and API.


### [Demo](https://github.com/gothinkster/realworld)&nbsp;&nbsp;&nbsp;&nbsp;[RealWorld](https://github.com/gothinkster/realworld)


This codebase was created to demonstrate a fully fledged fullstack application built with **Swift Server Side (Vapor)** including CRUD operations, authentication, routing, pagination, and more.

We've gone to great lengths to adhere to the **Swift** community styleguides & best practices.

For more information on how to this works with other frontends/backends, head over to the [RealWorld](https://github.com/gothinkster/realworld) repo.

# Getting started

## Prepare the environment

If you are running in a linux machine, do:

```bash
$ eval "$(curl -sL https://apt.vapor.sh)"
```

Else, if you are using mac machine, do:

```bash
$ brew install vapor/tap/vapor
```

If you do not have brew, then install it. You can find more detail instructions on [here](https://brew.sh/)

You can update the dependencies and generate a Xcode Project by typing.

```bash
$ vapor update
```
It will ask you whether you want to remake a Xcode Project and whether you want to open it. 

## Build and run

You could build and run from Xcode. Or, you could use:

```bash
$ vapor build
$ vapor run
```

## How to run migration?

You can run the migration by typing

```bash
$ vapor run prepare
```

**Atention:** Vapor is using Postgres 10 syntax, then you will need a postgre 10 running to get it working on migration :smile:

Have a look at [this](https://blog.2ndquadrant.com/postgresql-10-identity-columns/) to understand a little better





