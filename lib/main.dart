import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_game/pages/home.dart';
import 'package:gemini_game/themes/colors.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gemini Game',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        home: const HomePage(),
        debugShowCheckedModeBanner: false);
  }
}
