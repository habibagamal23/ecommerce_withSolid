import 'package:easy_localization/easy_localization.dart';
import 'package:fibeecomm/features/cart/logic/card_cubit.dart';
import 'package:fibeecomm/features/categoreis/logic/category_cubit.dart';
import 'package:fibeecomm/features/home/logic/home_cubit.dart';
import 'package:fibeecomm/features/paymentfet/logic/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'app_logic/localization/localization_cubit.dart';
import 'core/cachhelper/chachhelpe.dart';
import 'core/di/di.dart';
import 'core/route/checklogin.dart';
import 'features/Login/logic/login_cubit.dart';

import 'features/payment/Adressnew/new_adress_cubit.dart';
import 'features/payment/Adressnew/renew.dart';
import 'generated/codegen_loader.g.dart';
import 'myApp.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51QLO18KCYYcZnriZlyXhnG9ZCL51lgQVnNkTiSDje6oveaCmfxdUNmevP06mmqzdevZTi2GKJBTvsWRcM12u9jOY0043YgS4XM";
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
          BlocProvider(create: (context) => getit<CategoryCubit>()),
          BlocProvider(create: (context) => getit<cardCubit>()),
          BlocProvider(create: (context) => getit<PaymentCubit>()),

        ],
        child: const MyApp(),
      ),
    ),
  );
}
