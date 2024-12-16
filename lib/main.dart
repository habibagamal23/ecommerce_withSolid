import 'package:easy_localization/easy_localization.dart';
import 'package:fibeecomm/features/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_logic/localization/localization_cubit.dart';
import 'core/cachhelper/chachhelpe.dart';
import 'core/di/di.dart';
import 'core/route/checklogin.dart';
import 'features/Login/logic/login_cubit.dart';
import 'features/address/Adressnew/new_adress_cubit.dart';
import 'features/address/Adressnew/renew.dart';
import 'features/address/adress_cubit.dart';
import 'features/address/repo/addrepo.dart';
import 'generated/codegen_loader.g.dart';
import 'myApp.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  await EasyLocalization.ensureInitialized();
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  setGetit();
  await checkislogin();
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
          BlocProvider(create: (context) => getit<LoginCubit>()),
          BlocProvider(create: (context) => getit<HomeCubit>()..loginUser()),
          BlocProvider(
              create: (context) =>
              NewAdressCubit(LocationService())..fetchAddress()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
