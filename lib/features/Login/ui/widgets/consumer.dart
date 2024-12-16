import 'package:easy_localization/easy_localization.dart';
import 'package:fibeecomm/core/route/approuter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/CustomButton.dart';
import '../../../../core/widgets/dialog.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../logic/login_cubit.dart';
import 'Loading_widget.dart';

class ButtonConsumerBloc extends StatelessWidget {
  const ButtonConsumerBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          DialogManager.showErrorDialog(
            context: context,
            title: 'Error',
            description: 'Something went wrong ${state.meg}',
            onPress: () {
              context.pop();
            },
          );
        }
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Login successful! ${state.loginResponse.username}')),
          );
          context.go(ConstantsRoutes.CategoriesPage);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const PrettyLoadingWidget();
        }
        return Center(
          child: CustomButton(
            text: LocaleKeys.Authentication_bottom_login.tr(),
            onPressed: () {
              context.read<LoginCubit>().loginUser();
            },
          ),
        );
      },
    );
  }
}
