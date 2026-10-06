# Batch 5 — Shipping

Everything outside `lib/`: the web shell, SEO, the social preview image, and
host config for three platforms.

```
web/
├── index.html         SEO meta, Open Graph, JSON-LD, boot screen
├── manifest.json      PWA / installable
├── og-image.png       1200×630 social card  (generated)
├── robots.txt
├── sitemap.xml
└── _redirects         Netlify rewrite

firebase.json          Firebase Hosting + cache headers
netlify.toml           Netlify
vercel.json            Vercel
tool/generate_og_image.py
assets/images/projects/  empty folders, ready for screenshots
DEPLOY.md              build, deploy, and a pre-launch checklist
```

Merge these over your project root. `lib/` is included unchanged so this zip
is the complete project.

---

## pubspec — add the asset paths

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/images/projects/task-assistant/
    - assets/images/projects/loan-origination/
    - assets/images/projects/otc-desk/
    - assets/images/projects/geo-service/
```

Flutter does not recurse into subfolders, so each one has to be listed.

---

## The three things this batch fixes

**Blank link previews.** Sharing a Flutter web URL on LinkedIn or WhatsApp
currently shows a grey box. `og-image.png` plus the Open Graph tags give you
a proper card with your name, role and stack — before anyone clicks.

**The white flash.** Flutter web shows blank white for a second or two before
the first frame. `index.html` now holds the right background colour with the
"YK" mark and a sweeping rule, then fades out on `flutter-first-frame`. It
follows the system light/dark preference, and the animation stops under
reduced-motion.

**`/work` returning 404.** Clean URLs need the host to rewrite unknown paths
to `index.html`. Config for Firebase, Netlify and Vercel is included. Without
it, a shared deep link breaks — and a shared link is exactly how a recruiter
arrives.

---

## Before you deploy

Replace `https://yashkhade.dev` with your real domain in **three** files:
`web/index.html`, `web/robots.txt`, `web/sitemap.xml`.

Open Graph requires absolute URLs. Relative ones make the preview blank,
which defeats the point of the image.

---

## Honest note on Flutter web and SEO

Flutter renders to canvas, so Google sees almost no readable text. You will
not rank for content the way an HTML site would, and no amount of meta-tag
tuning changes that.

What does work:

- The **JSON-LD Person block** — your name, role, location and profile links
  in a format search engines read directly. This is why searching "Yash Khade
  Flutter" can surface you properly.
- `<title>` and `<meta description>`
- Inbound links from GitHub, LinkedIn and your résumé

If ranking for "flutter developer pune" ever matters more than the portfolio
itself, that's an argument for a static HTML site — not more tuning here. For
sending a link to a recruiter, which is the actual job, this is fine.

---

## The preview image

Regenerate any time your name or role changes:

```bash
python3 tool/generate_og_image.py
```

It uses Poppins, which was what I had available. For an exact match with the
site, install Bai Jamjuree and change `FONT_DIR` in the script.

---

## All five batches are done

```
1  Foundation   theme · typography · spacing · responsive · router
3  Components   33 shared widgets
2  Data         models + your real content, numbers derived
4  Features     every screen, built from the components
5  Shipping     web shell · SEO · OG image · deploy
```

What's left is yours, not code:

1. **Screenshots** → `assets/images/projects/<slug>/`
2. **Store / GitHub URLs** → `projects_data.dart`
3. **One metric per project** → `projects_data.dart`
4. **Resume URL** → `app_links.dart`
5. **Photo** → `assets/images/portrait.jpg` + `ProfileData.portraitPath`
6. **Delete `lib/features/gallery/`**
7. **Domain** → the three files above

`DEPLOY.md` has the build commands and a pre-launch checklist.

Send me screenshots whenever you have them and I'll wire them in and tune the
gallery spacing against the real images.
