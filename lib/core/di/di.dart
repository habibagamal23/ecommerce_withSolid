import 'package:dio/dio.dart';
import 'package:fibeecomm/features/Login/data/repos/LoginRepository.dart';
import 'package:fibeecomm/features/Login/data/repos/LoginRepositoryImpl.dart';
import 'package:fibeecomm/features/Login/logic/login_cubit.dart';
import 'package:fibeecomm/features/cart/data/repos/localrepo.dart';
import 'package:fibeecomm/features/cart/logic/card_cubit.dart';
import 'package:fibeecomm/features/home/data/repos/homerepo.dart';
import 'package:fibeecomm/features/home/data/repos/homerepoim.dart';
import 'package:fibeecomm/features/home/logic/home_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/cart/data/repos/cardepo.dart';
import '../../features/categoreis/data/repos/cartrepoimp.dart';
import '../../features/categoreis/data/repos/catrepo.dart';
import '../../features/categoreis/logic/category_cubit.dart';
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

///home
  getit.registerLazySingleton<homerepo>(
          () => homerepoimp(getit<ApiConsumer>()));

  ///cubit
  getit.registerFactory<HomeCubit>(() => HomeCubit(getit<homerepo>()));

  getit.registerLazySingleton<catrepo>(
          () => cartrepoimp(getit<ApiConsumer>()));

  ///cubit
  getit.registerFactory<CategoryCubit>(() => CategoryCubit(getit<catrepo>()));


  getit.registerLazySingleton<CartRepository>(
          () => LocalCartRepository());
  getit.registerFactory<cardCubit>(() => cardCubit(getit<CartRepository>()));

}
