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
      final savedLocale = context.locale ;
      emit(LocalizationChange(savedLocale));
    } catch (e) {
      emit(LocalizationChange(Locale('en')));
    }
  }

  /// Change language between English and Arabic
  Future<void> toggleLanguage(BuildContext context) async {
    final newLocale =
        (state.locale.languageCode == 'en') ? Locale('ar') : Locale('en');

    try {
      context.setLocale(newLocale);
      emit(LocalizationChange(newLocale));
    } catch (e) {
      print('Error toggling language: $e'); // Optional logging
    }
  }
}
