# Deploy

## 1. Before anything

Replace `https://yashkhade.dev` with your real domain in **three** files:

```
web/index.html      canonical, og:url, og:image, twitter:image, JSON-LD
web/robots.txt      the Sitemap line
web/sitemap.xml     every <loc>
```

Open Graph needs **absolute** URLs. Relative ones make the LinkedIn and
WhatsApp preview blank, which is the whole reason the image exists.

## 2. Build

```bash
flutter clean
flutter pub get
flutter build web --release
```

Output lands in `build/web/`.

## 3. Ship it

**Firebase Hosting** (`firebase.json` is ready):

```bash
npm i -g firebase-tools
firebase login
firebase init hosting     # choose existing project, public dir: build/web
                          # single-page app: YES, overwrite index.html: NO
firebase deploy --only hosting
```

**Netlify** (`netlify.toml` is ready) — drag `build/web` onto the dashboard,
or connect the repo with publish directory `build/web`.

**Vercel** (`vercel.json` is ready) — `vercel --prod` from the project root
after building.

**GitHub Pages** — works, but path URLs break (no rewrite rule available).
Either accept hash URLs by removing `configureUrlStrategy()` from `main.dart`,
or copy `build/web/index.html` to `build/web/404.html` as a workaround.

> **The rewrite rule is not optional.** Without it, `yashkhade.dev/work`
> returns 404 on a hard refresh or a shared link — and a shared link is
> exactly how a recruiter arrives.

## 4. Verify before you share it

- [ ] Paste the URL into the **LinkedIn Post Inspector** and the
      **Twitter Card Validator** — the card must show, not a grey box
- [ ] Open `/work` directly in a new tab. If it 404s, the rewrite is missing
- [ ] Hard refresh `/work/task-assistant` — same test
- [ ] Toggle dark/light, then reload — the choice must stick
- [ ] Run Lighthouse. Flutter web will not score well on SEO no matter what;
      the JSON-LD and meta tags are what carry you
- [ ] Open it on a real phone, not just a narrow browser window
- [ ] Submit the sitemap in Google Search Console

## 5. Honest note on Flutter web and SEO

Flutter renders to canvas. Google indexes the page but sees almost no text,
so you will not rank for content the way an HTML site would.

What actually works for you:

- The **JSON-LD Person block** in `index.html` — this is why searching your
  name can surface your role, location and links
- The `<title>` and `<meta description>`
- Inbound links from GitHub, LinkedIn and your résumé

If ranking for "flutter developer pune" ever matters more than the portfolio
itself, that's an argument for a static HTML site, not more tuning here. For
sending a link to a recruiter — which is the actual job — this is fine.

## 6. Regenerating the preview image

```bash
python3 tool/generate_og_image.py
```

It uses Poppins, which was what was available where I built it. For an exact
match with the site, install Bai Jamjuree and point `FONT_DIR` at it.
