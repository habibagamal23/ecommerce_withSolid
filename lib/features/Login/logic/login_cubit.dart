import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../data/models/LoginBodyRequest.dart';
import '../data/models/login_response.dart';
import '../data/repos/LoginRepository.dart';

part 'Login_State.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository LoginRepo;
  LoginCubit(this.LoginRepo) : super(LoginInitial());

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> loginUser() async {
    emit(LoginLoading());
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      LoginBodyRequest loginBodyRequest =
          LoginBodyRequest(username: username.text, password: password.text);
      final result = await LoginRepo.loginUser(login: loginBodyRequest);
      if (result.isSuccess) {
        emit(LoginSuccess(result.data!));
      } else {
        emit(LoginError(result.error!));
      }
    } catch (e) {
      emit(LoginError("Error login ${e.toString()}"));
    }
  }

  @override
  Future<void> close() {
    username.dispose();
    password.dispose();
    // TODO: implement close
    return super.close();
  }
}
