import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/CustomFormTextField.dart';
import '../../../../core/widgets/spacing.dart';
import '../../logic/login_cubit.dart';

class Usernameandpassword extends StatelessWidget {
  const Usernameandpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: context.read<LoginCubit>().formKey,
        child: Column(
          children: [
            CustomFormTextField(
              hintText: 'Enter your username',
              labelText: 'Username',
              controller: context.read<LoginCubit>().username,
            ),
            verticalSpace(20),
            CustomFormTextField(
              hintText: 'Enter your password',
              labelText: 'Password',
              controller: context.read<LoginCubit>().password,
            ),
          ],
        ));
  }
}
