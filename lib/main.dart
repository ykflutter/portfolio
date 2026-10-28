import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'app/app.dart';
import 'app/theme_controller.dart';
import 'core/utils/url_strategy/url_strategy.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureUrlStrategy();

  // Scroll reveals check visibility on this interval. The 500ms default
  // makes sections appear noticeably late.
  VisibilityDetectorController.instance.updateInterval =
      const Duration(milliseconds: 60);

  // Every orientation is supported — layouts adapt on rotation.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Firebase backs hosting and a future contact form. A failure here must
  // not stop the site from rendering.
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (_) {}

  await themeController.load();

  runApp(const PortfolioApp());
}
