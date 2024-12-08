import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/network/dio_network/dio_service.dart';
import 'core/network/dio_network/diofactory.dart';
import 'features/Login/data/repos/LoginRepositoryImpl.dart';
import 'features/Login/logic/login_cubit.dart';
import 'myApp.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => LoginCubit(
              LoginRepositoryImpl(DioService(dio: DioFcatory().dio))))
    ], child: const MyApp()),
  );
}
