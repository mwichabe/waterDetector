import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:water_detector_app/generated/intl/messages_all.dart';
import 'package:water_detector_app/main.dart';

class LanguageSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Language\nPreferences',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade100,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Your Preferred Language',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildLanguageOption('English', 'en_US', context),
            _buildLanguageOption('Spanish', 'es_US', context),
            // Add more language preferences options as needed
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
      String language, String locale, BuildContext context) {
    return RadioListTile(
      title: Text(language),
      value: locale,
      groupValue:
          Provider.of<LanguageNotifier>(context).currentLocale.toString(),
      onChanged: (value) {
        _changeLanguage(value!, context);
      },
    );
  }

  void _changeLanguage(String locale, BuildContext context) {
    Provider.of<LanguageNotifier>(context, listen: false).currentLocale =
        Locale(locale);
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }
}

class S {
  static String translate(String key) {
    return Intl.message(key, name: key, desc: key);
  }

  static Future<S> load(Locale locale) {
    final String name =
        locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  }

  // Add translations for each key used in your app
  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }
}
