# `web/` — complete replacement

Drop this `web/` folder over yours. It replaces all four files you have plus
`icons/`, and adds four new ones.

```
web/
  index.html          ← replaced
  manifest.json       ← replaced
  favicon.png         ← replaced (was the Flutter default)
  icons/              ← replaced (4 files, were Flutter defaults)
  og-image.png        ← new, 1200×630 social card
  robots.txt          ← new
  sitemap.xml         ← new
  _redirects          ← new (only used if you ever host on Netlify)
```

---

## index.html

**Kept from yours:** `$FLUTTER_BASE_HREF`, `flutter_bootstrap.js`, the
favicon and apple-touch-icon links, the `apple-mobile-web-app-*` tags, author,
site name, and `https://yashkhade.web.app` as the live url.

**Fixed:**

- **Added `<meta name="viewport">`.** Yours has none, so phones render the
  page at ~980px and scale it down — every visitor on mobile sees a zoomed-out
  desktop layout. This is the one item that undoes the responsive work in `lib/`.
- `og:image` pointed at `favicon.png` while `twitter:card` asked for
  `summary_large_image`. Now points at `og-image.png` with explicit
  `og:image:width` / `:height` — LinkedIn often refuses to render a card
  without the dimensions.
- Added `canonical`, `og:type`, `twitter:title`, `twitter:description`,
  `twitter:image`, and `theme-color` for both colour schemes.
- Added a JSON-LD `Person` block. Worth being blunt about why: Flutter's
  canvas renderer paints your text into a canvas, so crawlers read almost
  nothing off your page. Structured data is the only part Google can actually
  parse. Don't expect to rank for "flutter developer pune" on page content —
  this plus inbound links is the realistic lever.
- `apple-mobile-web-app-status-bar-style` changed from `black-translucent` to
  `default`. Translucent pushes your content up under the iOS status bar,
  which overlaps the nav bar in standalone mode.

**Loader rebuilt.** Yours was a white page with a `#2563eb` blue spinner — a
colour that appears nowhere in the palette — so a dark-theme visitor got a
white flash before a `#0A0A0A` app. The new one reads `prefers-color-scheme`,
uses the real `AppColors` values on both sides, honours
`prefers-reduced-motion`, and removes itself on `flutter-first-frame` instead
of waiting for Flutter to tear it down.

**Removed:** `body { display:flex; height:100vh }` (can fight Flutter's host
sizing on iOS Safari), the deprecated `<center>`, `X-UA-Compatible` (only
ever did anything for IE), and `<meta name="keywords">` — Google has ignored
it since 2009. Say so if you'd rather keep it; it does no harm, it just does
nothing.

**Title** changed from "Flutter Developer & UI Designer" to
"Flutter Developer", matching `ProfileData.role`. Two different job titles on
the same site reads as careless to anyone comparing the tab to the hero.

---

## manifest.json

Yours still said `"description": "A new Flutter project."` and
`"name": "yashkhade"` — that's what shows under the icon when someone installs
the site, and it's the Flutter template default.

Colours were `#020617` / `#3B82F6`, from the old blue theme. Now `#0A0A0A`
both, matching `AppColors.darkBackground`.

Also added `id`, `scope`, `lang`, changed `start_url` from `"."` to `"/"`
(relative start urls break when installed from a deep link like
`/work/otc-desk`), and loosened `orientation` from `portrait-primary` — the
site has a desktop layout, locking it to portrait is wrong.

---

## Icons

Regenerated as a monochrome "YK" mark from the palette, by
`tool/generate_icons.py`. Maskable variants keep the mark inside the central
80% safe zone, since Android crops them to whatever shape the launcher uses.

Re-run any time: `python3 tool/generate_icons.py`

If you'd rather use a logo you already own, drop it in and skip the script —
just keep the five filenames.

---

## robots.txt / sitemap.xml

Nine urls, matching your real router paths: `/`, `/work`, the four
`/work/<slug>` pages, `/experience`, `/skills`, `/contact`. `/writing` is
excluded because `ArticlesData.hasPublished` is false; `/components` is
excluded on purpose — it's the dev gallery.

Deep links only resolve because of the `rewrites` rule in `firebase.json`.
Don't remove it.

---

## After deploying

Run the live url through LinkedIn's Post Inspector once before you share it
anywhere. LinkedIn caches preview cards hard, and a bad first fetch sticks.
