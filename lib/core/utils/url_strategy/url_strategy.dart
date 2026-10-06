/// Picks the right implementation per platform.
///
/// `flutter_web_plugins` is web-only — importing it directly in main.dart
/// breaks the Android/iOS build. This conditional export keeps both working.
export 'url_strategy_stub.dart'
    if (dart.library.js_interop) 'url_strategy_web.dart';
