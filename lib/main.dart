import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_logic/localization/localization_cubit.dart';
import 'core/cachhelper/chachhelpe.dart';
import 'core/di/di.dart';
import 'features/Login/logic/login_cubit.dart';
import 'generated/codegen_loader.g.dart';
import 'myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  await EasyLocalization.ensureInitialized();
  setGetit();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LocalizationCubit()..loadLang(context),
          ),
          BlocProvider(create: (context) => getit<LoginCubit>())
        ],
        child: const MyApp(),
      ),
    ),
  );
}
