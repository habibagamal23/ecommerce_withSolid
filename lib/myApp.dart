import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/route/approuter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Fibo Ecommerce',
      ),
    );
  }
}
