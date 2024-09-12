
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iam_mobile/src/routers/constant.dart';
import 'package:iam_mobile/src/routers/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // enableScaleWH: ()=>false,
        enableScaleText: ()=>true,
        builder: (_, child) {
          return GetMaterialApp(
            builder: (context, widget) {
              return MediaQuery(
                ///Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                child: widget!,
              );
            },
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: rootRoute,
            getPages: routes,
          );}
    );
  }
}