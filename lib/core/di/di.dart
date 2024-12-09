import 'package:dio/dio.dart';
import 'package:fibeecomm/features/Login/data/repos/LoginRepository.dart';
import 'package:fibeecomm/features/Login/data/repos/LoginRepositoryImpl.dart';
import 'package:fibeecomm/features/Login/logic/login_cubit.dart';
import 'package:get_it/get_it.dart';

import '../network/apiConsumer.dart';
import '../network/dio_network/dio_service.dart';
import '../network/dio_network/diofactory.dart';

final getit = GetIt.instance;

void setGetit() {
  /// dio
  getit.registerLazySingleton<Dio>(() => DioFcatory().dio);

  /// api consumer
  getit.registerLazySingleton<ApiConsumer>(() => DioService(dio: getit<Dio>()));

  /// repositry
  getit.registerLazySingleton<LoginRepository>(
          () => LoginRepositoryImpl(getit<ApiConsumer>()));

  ///cubit
  getit.registerFactory<LoginCubit>(() => LoginCubit(getit<LoginRepository>()));
}