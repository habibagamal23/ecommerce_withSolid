import 'package:easy_localization/easy_localization.dart';
import 'package:fibeecomm/features/Login/ui/widgets/Usernameandpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_logic/localization/localization_cubit.dart';
import '../../../../core/widgets/spacing.dart';

import '../../../../generated/locale_keys.g.dart';
import '../widgets/consumer.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<LocalizationCubit>().changeLanguage(context);
              },
              icon: Icon(Icons.change_circle))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(40),
              Text(
                LocaleKeys.Authentication_title_Login.tr(),
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
