
import 'package:filtrate/Core/AppRoutes/app_route.dart';
import 'package:filtrate/Helper/shared_preferences.dart';
import 'package:filtrate/Utils/AppConst/app_const.dart';
import 'package:filtrate/View/Widget/ToastSnackBar/toast.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) async {
    if (response.statusCode == 401) {
      await SharePrefsHelper.remove(AppConstants.bearerToken);
      Get.offAllNamed(AppRoute.homePage);
    } else {
      showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
    }
  }
}
