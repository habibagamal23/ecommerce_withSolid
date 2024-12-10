import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../app_logic/localization/localization_cubit.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        return SwitchListTile(
          title: Text(
            state.locale.languageCode == 'en' ? 'English' : 'العربية',
            style: const TextStyle(fontSize: 18),
          ),
          value: state.locale.languageCode == 'ar', // Show if Arabic is selected
          onChanged: (bool isArabic) {
            // Toggle the locale using the cubit
            context.read<LocalizationCubit>().toggleLocale();

            // After emitting the new state, set the locale with EasyLocalization
            final newLocale = context.read<LocalizationCubit>().state.locale;
            context.setLocale(newLocale);  // Change the locale with EasyLocalization
          },
        );
      },
    );
  }
}
