# Color palette explanation

Inspired by [Material You][1] and [base16][2]

[1]: https://m3.material.io/styles/colors/roles
[2]: https://github.com/chriskempson/base16

These are color roles that can fit many palettes, such that changing color palettes would not require changing all the color names in the scss files.

## Neutral Colors

`$string`: the foreground, often text or borders

- `$string-dim`: string, but with less contrast with base

`$box`: lighter (in a dark palette) or darker (in a dark palette) than base

- Often used for buttons, hover backgrounds, etc.
- `$box-bright`: more contrast with base
- `$box-dim`: less contrast with base

`$base`: the background

- Determines if the palette is light or dark

`$shadow`: very dark, mostly for box shadows

## Accents

`$primary`: main accent, high emphasis

- `$primary-bright`: lighter in value and/or warmer in hue than primary
- `$primary-dim`: darker in value and/or cooler in hue than primary

`$secondary`: less emphasis, pairs well with primary

- `$secondary-bright`
- `$secondary-dim`

`$tertiary`: contrasting accent, very high emphasis

- `$tertiary-bright`
- `$tertiary-dim`

## Indicator Colors

`$good`: often green

`$warn`: often yellow or orange

`$error`: often red
