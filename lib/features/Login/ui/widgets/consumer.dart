import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/CustomButton.dart';
import '../../logic/login_cubit.dart';
import 'Loading_widget.dart';

class ButtonConsumerBloc extends StatelessWidget {
  const ButtonConsumerBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.meg)),
          );
        }
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful! ${state.loginResponse.username}' )),
          );
          // Navigate to the next screen
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const LoadingWidget();
        }
        return CustomButton(
          text: 'Login',
          onPressed: () {
            context.read<LoginCubit>().loginUser();
          },
        );
      },
    );
  }
}
