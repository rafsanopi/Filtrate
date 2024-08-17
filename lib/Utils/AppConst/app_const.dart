import 'dart:io';

class AppConstants {
  static String bearerToken = "BearerToken";
  // static String userId = "UserId";
  static String onBoard = "Onboard";

  /// <====================== All Response Message Static==============================>

  static String successfull = "Request Successfull";
  static String error = "Oops, something went wrong";
  static String profileID = "profileID";
  static String userStatus = "userStatus";
  static String rememberMe = "rememberMe";

  static String bannerAdsId = Platform.isAndroid
      ? 'ca-app-pub-2906458878144502/5816785841'
      : 'ca-app-pub-2906458878144502/1628676128';

  static String interstitialAdsId = Platform.isAndroid
      ? 'ca-app-pub-2906458878144502/7285780187'
      : 'ca-app-pub-2906458878144502/8824639865';

  // ca-app-pub-7278830824707729~1929633498 ------ Ios interstitialAdsId

  // ca-app-pub-7278830824707729~8653038107 ------ Android interstitialAdsId

  static String onlineImage =
      "https://img.freepik.com/free-photo/user-sign-icon-front-side-with-white-background_187299-40022.jpg?w=740&t=st=1705481431~exp=1705482031~hmac=89e2b2de749a608d27e73991f06a1e449c6e4ab8f8e9c74465b18ec415db010f";
}

/// otp screen type

enum OptScreenType { signupotp, forgotOtp }

enum ContentPermission { pendingCreator, creator, user }

enum Status { loading, error, completed, internetError }

enum APIStatus { movie, tvSeries, music }
