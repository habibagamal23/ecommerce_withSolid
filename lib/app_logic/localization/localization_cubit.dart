import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizatioInitial());

  /// Load the saved language or fallback to English
  Future<void> loadLang(BuildContext context) async {
    try {
      final savedLocale = EasyLocalization.of(context)?.locale ?? Locale('en');
      emit(LocalizationChange(savedLocale));
    } catch (e) {
      emit(
          LocalizationChange(Locale('en')));
    }
  }

  /// Change language between English and Arabic
  Future<void> changeLanguage(BuildContext context) async {
    try {
      // Get current locale
      final currentLocale = state.locale;
      final Locale newLocale ;
      if (currentLocale.languageCode == 'en') {
        newLocale = const Locale('ar');
      } else {
        newLocale = const Locale('en');
      }
      context.setLocale(newLocale);
      emit(LocalizationChange(newLocale));
    } catch (e) {
      print('Error changing language: $e');
    }
  }
}
