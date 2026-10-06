cat > README.md <<'MDEOF'
# Portfolio

My personal portfolio, built in Flutter web.

**Live:** https://yashkhade.web.app

## Stack

- **Flutter web** with `go_router` and real URL paths — every section is
  linkable, and browser back works the way people expect.
- **Design system in `core/theme/`** — colours, spacing, typography,
  durations and radii all live in one place. No widget file declares a raw
  `Color`, `fontSize` or spacing number.
- **Light/dark theme** with a circular-reveal transition, persisted via
  `shared_preferences`.
- **Dependency-free scroll reveals** — `RevealOnScroll` listens to the
  enclosing `Scrollable`, and everything respects
  `MediaQuery.disableAnimationsOf` for reduced-motion users.
- **Derived stats** — years of experience, project and skill counts are all
  computed from the content files, so the home page can't contradict the
  detail pages.

## Structure

    lib/
      app/        MaterialApp, router, theme controller
      core/       theme, responsive helpers, extensions, constants
      data/       models + static content (the only place content lives)
      features/   one folder per screen, split into sections/widgets
      shared/     reusable components — buttons, cards, chips, motion, layout

Content is data, not markup: everything on the site comes from
`lib/data/content/`. Adding a project means adding an entry, not editing a
screen.

## Running it

    flutter pub get
    flutter run -d chrome

## Deploying

    flutter build web --release
    firebase deploy --only hosting
