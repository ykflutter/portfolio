import 'package:flutter_web_plugins/url_strategy.dart';

/// Clean URLs: /work instead of /#/work.
///
/// Requires the host to rewrite unknown paths to index.html, otherwise a
/// direct visit to /work 404s. Firebase Hosting and Netlify do this with a
/// single rewrite rule — see the README in this zip.
void configureUrlStrategy() => usePathUrlStrategy();
