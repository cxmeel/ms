<!-- Links -->

[vercel/ms]: https://github.com/vercel/ms
[ms/releases]: https://github.com/csqrl/ms/releases
[ms/wally]: https://wally.run/package/csqrl/ms
[ms/npm]: https://npmjs.com/package/@csqrl/ms

<!-- Shields -->

[shields/github-release]: https://img.shields.io/github/v/release/csqrl/ms?label=latest+release&style=flat
[shields/wally]: https://img.shields.io/endpoint?url=https://runkit.io/clockworksquirrel/wally-version-shield/branches/master/csqrl/ms&color=blue&label=wally&style=flat
[shields/npm]: https://img.shields.io/npm/v/@csqrl/ms?style=flat

# ms

[![Latest GitHub version][shields/github-release]][ms/releases] [![Latest Wally version][shields/wally]][ms/wally] [![Latest NPM version][shields/npm]][ms/npm]

Utility library to convert to/from milliseconds. Based on [vercel/ms][vercel/ms].

## Installation

### Installing with Wally

Add an entry to your `wally.toml` file and run `wally install`.

```toml
[dependencies]
ms = "csqrl/ms@x.x.x" # Replace x.x.x with the latest version
```

### GitHub Releases

Pre-built binaries are available on the [releases][ms/releases] page. Download the latest `rbxm` file and drop it into Studio.

## Examples

> Commas added for legibility. Actual output is an integer.

```lua
ms("2 days")    --  172,800,000
ms("1d")        --  86,400,000
ms("10h")       --  36,000,000
ms("2.5 hrs")   --  9,000,000
ms("2h")        --  7,200,000
ms("1m")        --  60,000
ms("5s")        --  5,000
ms("1y")        --  31,556,995,200
ms("100")       --  100
ms("-3 days")   -- -259,200,000
ms("-1h")       -- -3,600,000
ms("-200")      -- -200
```

## Combine Inputs

```lua
ms("1d, 10h")                    --  122,400,000
ms("2 days, 1m")                 --  172,860,000
ms("-3days+1d")                  -- -172,860,000
ms("1y,6mo 5wks-2d 32m 1240ms")  --  49,962,116,440
ms("6 years")                    --  189,345,600,000
```

### Convert to Seconds

```lua
ms("1 hour", "s")  -- 3,600
ms("1d", "s")      -- 86,400
```

### Convert from Milliseconds

```lua
ms(60000)           -- "1m"
ms(2 * 60000)       -- "2m"
ms(-3 * 60000)      -- "-3m"
ms(ms("10 hours"))  -- "10h"
```

### Convert to Long Format

```lua
ms(60000, "long")           -- "1 minute"
ms(2 * 60000, "long")       -- "2 minutes"
ms(-3 * 60000, "long")      -- "-3 minutes"
ms(ms("10 hours"), "long")  -- "10 hours"
```

### Convert with Units

```lua
ms(60000, "short")          -- "1m"
ms(60000, "long", "s")      -- "17 hours"
ms(60, nil, "s")            -- "1 minute"
ms(1, "long", "h")          -- "1 hour"
```
