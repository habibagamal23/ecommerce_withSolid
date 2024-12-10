import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(const LocalizationInitial(Locale('en')));

  // Toggle between English and Arabic locales
  void toggleLocale() {
    final currentLocale = state.locale;
    Locale newLocale;

    if (currentLocale.languageCode == 'en') {
      newLocale = const Locale('ar');
    } else {
      newLocale = const Locale('en');
    }

    // Emit new state with the updated locale
    emit(LocalizationChanged(newLocale));
  }
}
