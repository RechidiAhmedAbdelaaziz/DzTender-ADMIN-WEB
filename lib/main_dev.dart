import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/app.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:tender/core/di/container.dart';

void main() async {
  // ensure initializeApp is called
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    name: "DEV",
    color: Colors.deepOrange,
    location: BannerLocation.topEnd,
    variables: {
      "baseUrl": "http://localhost:3000",
    },
  );

  // Enable path-based URLs
  setUrlStrategy(PathUrlStrategy());

  // register dependencies
  await setupLocator();

  await ScreenUtil.ensureScreenSize();

  runApp(const TenderApp());
}
