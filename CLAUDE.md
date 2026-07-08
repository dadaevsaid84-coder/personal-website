# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

Static one-page personal portfolio site for Said Dadaev / "VibeCodding" brand
(`index.html`, `style.css`, `script.js`, `profile.png`). No build tooling, no
package manager, no framework — plain HTML/CSS/JS served as-is. Content and
UI copy are in Uzbek.

## Commands

There is no build/lint/test pipeline. To preview changes, open `index.html`
directly in a browser (or use a simple static file server) — no compile step
is needed.

## Architecture

Everything lives in three files that load in this order: `index.html` →
`style.css` → `script.js` (script tag at the end of `<body>`).

- **`index.html`** — single page with anchor-linked sections in this order:
  `#hero`, `#about`, `#skills`, `#projects`, `#services`, `#contact`, followed
  by a footer. The navbar (`.navbar`) links to each section by id. Adding a
  new section means adding both the `<section id="...">` block and a matching
  `.nav-links` entry.
- **Theme system** — dark/light mode is controlled via a `data-theme`
  attribute on `<html>`, set by an inline `<script>` in `<head>` (before CSS
  loads, to avoid a flash of the wrong theme) reading `localStorage.theme` or
  falling back to `prefers-color-scheme`. `style.css` defines all themeable
  values as CSS custom properties in `:root`, overridden under
  `[data-theme="light"]`. `script.js`'s `themeToggle` click handler flips the
  attribute and persists the choice to `localStorage`.
- **`script.js` behaviors** (all vanilla JS, no dependencies):
  - Footer year injection (`#year`).
  - Theme toggle (see above).
  - Cursor-follow glow effect: mousemove updates CSS vars `--x`/`--y`
    consumed by `.cursor-glow` in `style.css`.
  - Mobile nav burger menu: toggles `.open` class on `#navLinks`; clicking any
    nav link closes it.
  - Scroll-reveal animation: `IntersectionObserver` adds `.visible` to any
    element with class `.reveal` once it enters the viewport (threshold
    0.15), then stops observing it. New sections/cards that should animate in
    need the `.reveal` class added manually.
- **`style.css` structure** — CSS custom properties first (color/theme
  tokens), then base resets, then components in the same order they appear on
  the page (navbar → hero → sections → cards → contact → footer), then
  responsive breakpoints at 900px and 720px at the bottom.

## Notes

- Fonts (`Space Grotesk`, `Inter`) are loaded from Google Fonts via `<link>`
  tags in `index.html` — no local font files.
- Social links (Telegram, Instagram, YouTube, Facebook) are hardcoded in two
  places: the hero section and the contact section — keep both in sync when
  changing a handle.
- `.claude/` is git-ignored (local tooling config, not part of the site).
