# rod

Crystal port of the [go-rod/rod](https://github.com/go-rod/rod) library for browser automation.

This is a Crystal port of the Go rod library, a high-level driver directly based on DevTools Protocol.
It's designed for web automation and scraping for both high-level and low-level use.

**Source:** The original Go source code is available in the `vendor/` submodule at commit [`1cd7eb9`](https://github.com/go-rod/rod/tree/1cd7eb98e9d3c5c032f08a4b6084a220f44a71f7).
All logic matches the Go implementation, differing only in Crystal language idioms and libraries.

## Features

- Chained context design, intuitive to timeout or cancel long-running tasks
- Auto-wait elements to be ready
- Debugging friendly, auto input tracing, remote monitoring headless browser
- Thread-safe for all operations
- Automatically find or download browser
- High-level helpers like WaitStable, WaitRequestIdle, HijackRequests, WaitDownload, etc.
- Two-step WaitEvent design, never miss an event
- Correctly handles nested iframes or shadow DOMs
- No zombie browser process after crash

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     rod:
       github: dsisnero/rod
   ```

2. Run `shards install`

## Usage

```crystal
require "rod"
```

The API is similar to the Go version. Please refer to the [original documentation](https://go-rod.github.io/) for concepts and examples.

Basic example (adapted from Go):

```crystal
# TODO: Add Crystal example after porting
```

## Development

This project uses a standard Crystal development workflow with `make` targets:

- `make install` – Install dependencies
- `make update` – Update dependencies
- `make format` – Check code formatting
- `make lint` – Run ameba linter
- `make test` – Run specs
- `make clean` – Clean temporary files

See `AGENTS.md` for detailed porting guidelines and issue tracking.

## Contributing

This is a porting project. All contributions should maintain behavioral equivalence with the original Go code.

1. Fork it (<https://github.com/dsisnero/rod/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Please read the porting guidelines in `AGENTS.md` before contributing.

## Contributors

- [Dominic Sisneros](https://github.com/dsisnero) – creator and maintainer
- Original Go library authors and contributors – [go-rod/rod contributors](https://github.com/go-rod/rod/graphs/contributors)