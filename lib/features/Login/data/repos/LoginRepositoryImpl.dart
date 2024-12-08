import 'package:fibeecomm/core/network/ApiResult.dart';

import 'package:fibeecomm/features/Login/data/models/login_response.dart';

import '../../../../core/network/ApiConstants.dart';
import '../../../../core/network/apiConsumer.dart';
import '../models/LoginBodyRequest.dart';
import 'LoginRepository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final ApiConsumer apiConsumer;

  LoginRepositoryImpl(this.apiConsumer);

  @override
  Future<ApiResult<LoginResponse>> loginUser(
      {required LoginBodyRequest login}) async {
    try {
      final response = await apiConsumer.post(
        ApiConstants.login,
        data: login.toJson(),
      );
      return ApiResult.success(LoginResponse.fromJson(response));
    } catch (e) {
      return ApiResult.error('Failed to Login user : ${e.toString()}');
    }
  }
}
