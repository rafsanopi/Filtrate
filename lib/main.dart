import 'package:filtrate/Core/AppRoutes/app_route.dart';
import 'package:filtrate/Core/DependancInjection/di.dart';
import 'package:filtrate/Global/Theme/light.dart';
import 'package:filtrate/View/Widget/DevicePreview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceUtils.lockDevicePortrait();
  DeviceUtils.statusBarColor();
  DependancyInjection di = DependancyInjection();
  di.dependencies();
  MobileAds.instance.initialize();
  var deviceId = ["5C1691C82C39BFE2F344F796B3A4E2BC"];
  // var deviceId = ["31373CB13168498A6EA2DC430CC474F3"];
  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: deviceId);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ///<====================This widget is the root of your application======================>

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: AppRoute.routes,
          defaultTransition: Transition.noTransition,
          transitionDuration: const Duration(milliseconds: 200),
          navigatorKey: Get.key,
          initialRoute: AppRoute.splashScreen,
          theme: lightModeTheme,
        );
      },
    );
  }
}
