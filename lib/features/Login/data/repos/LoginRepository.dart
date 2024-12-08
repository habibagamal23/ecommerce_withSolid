import '../../../../core/network/ApiResult.dart';
import '../models/LoginBodyRequest.dart';
import '../models/login_response.dart';

// open closed and
abstract class LoginRepository {
  Future<ApiResult<LoginResponse>> loginUser({required LoginBodyRequest login});
}
