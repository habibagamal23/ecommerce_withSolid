import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_logic/localization/localization_cubit.dart';
import '../../core/widgets/toggole.dart';
import '../../generated/locale_keys.g.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.Authentication_title_Login).tr(),
            const SizedBox(height: 20),
            const LanguageToggle(),  // Language toggle widget
          ],
        ),
      ),
    );
  }
}
