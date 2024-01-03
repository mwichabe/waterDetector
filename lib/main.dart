import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_detector_app/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class LanguageNotifier with ChangeNotifier {
  late Locale _currentLocale;

  LanguageNotifier(this._currentLocale);

  Locale get currentLocale => _currentLocale;

  set currentLocale(Locale newLocale) {
    _currentLocale = newLocale;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LanguageNotifier(Locale('en', 'US')),
      child: Consumer<LanguageNotifier>(
        builder: (context, languageNotifier, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Main DashBoard',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
