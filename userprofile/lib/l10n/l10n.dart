import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class L10n {
  static final all = [
    const Locale("en"),
    const Locale("ar"),
  ];

  static List<LocalizationsDelegate<dynamic>> get localizationsDelegates {
    return [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ];
  }
}
