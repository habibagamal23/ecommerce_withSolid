import 'package:fibeecomm/features/Login/ui/widgets/Usernameandpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/ColorsManager.dart';
import '../../../../core/widgets/CustomButton.dart';
import '../../../../core/widgets/CustomFormTextField.dart';
import '../../../../core/widgets/spacing.dart';
import '../../logic/login_cubit.dart';
import '../widgets/Loading_widget.dart';
import '../widgets/consumer.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(40),
              Text(
                'Welcome Back',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: ColorsManager.mainDark),
              ),
              verticalSpace(20),
              const Usernameandpassword(),
              verticalSpace(20),
             const ButtonConsumerBloc()
            ],
          ),
        ),
      ),
    );
  }
}
