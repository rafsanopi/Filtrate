import 'package:filtrate/View/Screens/CategaryScreens/inner/about_us.dart';
import 'package:filtrate/View/Screens/CategaryScreens/categary.dart';
import 'package:filtrate/View/Screens/CategaryScreens/inner/terms.dart';
import 'package:filtrate/View/Screens/HomPage/InnerWidget/see_all.dart';
import 'package:filtrate/View/Screens/HomPage/SearchByCetegary/by_cetegary.dart';
import 'package:filtrate/View/Screens/HomPage/home_page.dart';
import 'package:filtrate/View/Screens/OnBoarding/onboarding.dart';
import 'package:filtrate/View/Screens/SearchPage/ChoseCeteGary/chose_cetegary.dart';
import 'package:filtrate/View/Screens/SearchPage/search.dart';
import 'package:filtrate/View/Screens/SplashScreens/splash.dart';
import 'package:filtrate/View/Screens/chat_gpt_screen/chat_gpt_response.dart';
import 'package:filtrate/View/Screens/chat_gpt_screen/chat_gpt_screen.dart';
import 'package:filtrate/View/Screens/history/history.dart';
import 'package:filtrate/View/Screens/more_category/choose_final_categories.dart';
import 'package:filtrate/View/Screens/more_category/more_category.dart';
import 'package:get/get.dart';

class AppRoute {
  static const String splashScreen = "/splash_screen";
  static const String onBoardingScreen = "/onBoardingScreen";
  static const String homePage = "/homePage";
  static const String searchScreen = "/searchScreen";
  static const String chatGptScreen = "/chatGptScreen";
  static const String chatGptResponse = "/chatGptResponse";
  static const String moreCategory = "/moreCategory";

  static const String cetegaryScreen = "/cetegaryScreen";
  static const String seeAllScreen = "/seeAllScreen";
  static const String choseCetegaryScreen = "/choseCetegaryScreen";
  static const String termsAndCondition = "/termsAndCondition";
  static const String aboutUs = "/aboutUs";
  static const String searchByCetegaryScreen = "/searchBuCetegaryScreen";

  static const String chooseFinalCategories = "/chooseFinalCategories";
  static const String history = "/history";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: homePage, page: () => const HomePage()),
    GetPage(name: onBoardingScreen, page: () => const OnBoardingPage()),
    GetPage(name: searchScreen, page: () => SearchPage()),
    GetPage(name: chatGptScreen, page: () => ChatGPtScreen()),
    GetPage(name: chatGptResponse, page: () => ChatGptResponse()),
    GetPage(name: moreCategory, page: () => MoreCategory()),
    GetPage(name: cetegaryScreen, page: () => const CetegaryPage()),
    GetPage(name: seeAllScreen, page: () => const SeeAllPage()),
    GetPage(name: choseCetegaryScreen, page: () => const ChoseCetegaryPage()),
    GetPage(name: termsAndCondition, page: () => const TermsAndCondition()),
    GetPage(name: aboutUs, page: () => const AboutUs()),
    GetPage(name: searchByCetegaryScreen, page: () => SearchByCetegary()),
    GetPage(
        name: chooseFinalCategories, page: () => const ChooseFinalCategories()),
    GetPage(name: history, page: () => HistoryScreen()),
  ];
}
