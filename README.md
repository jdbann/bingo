# Bingo

Shows a scrolling marquee of calls from a round. For embedding in a [browser
source] using [OBS].

[OBS]: https://obsproject.com
[browser source]: https://obsproject.com/wiki/Sources-Guide#browsersource

## Requirements

- Ruby 2.6.4
- Yarn
- Postgres

## Setup

```
$ bin/setup
```

## Testing

Tests are handled by rspec:

```
$ rails spec
```

## Linting

Run linting before merging. Linting for ruby, js and scss is setup:

```
$ rails lint      # Runs lint:ruby, lint:js and lint:scss
$ rails lint:ruby # Runs rubocop
$ rails lint:js   # Runs eslint
$ rails lint:scss # Rubs scss-lint
```
