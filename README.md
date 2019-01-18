# Facebook Clone

Recreating the Facebook website.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, create and migrate the database:

```
$ rake db:create
```

```
$ rake db:migrate
```

Next, seed the database with a few users and tweets:

```
$ rails db:seed
```

Run the app in a local server:

```
$ rails server
```
