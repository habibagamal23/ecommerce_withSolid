import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_logic/localization/localization_cubit.dart';
import 'core/route/approuter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        // Set the current locale from the cubit state
        final locale = state is LocalizationChanged ? state.locale : Locale('en');

        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp.router(
              locale: locale,  // Apply the locale dynamically
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
              title: 'Fibo Ecommerce',
            );
          },
        );
      },
    );
  }
}

