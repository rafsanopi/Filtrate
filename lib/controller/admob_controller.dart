import 'package:filtrate/Utils/AppConst/app_const.dart';
import 'package:filtrate/View/Widget/ToastSnackBar/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobController extends GetxController with GetxServiceMixin {
  List<BannerAd> bannerAds = [];

  ///=============== Generated 20 Banner Ads ==============

  loadMultipleBannerAds() {
    for (int i = 0; i < 20; i++) {
      // Load 10 banner ads, adjust as needed
      BannerAd bannerAdd = BannerAd(
        adUnitId: AppConstants.bannerAdsId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (_) {},
          onAdFailedToLoad: (_, error) {
            debugPrint('Ad failed to load: $error');
          },
        ),
      )..load();
      bannerAds.add(bannerAdd); // Add the loaded banner ad to the list
    }
  }

  ///====================== InterstitialAd =======================

  RxBool isFullPage = false.obs;
  void initializeFullPageAd({required VoidCallback adsCloseOnTap}) async {
    isFullPage.value = true;
    refresh();
    try {
      await InterstitialAd.load(
        adUnitId: AppConstants.interstitialAdsId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          ad.show();
          ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {
                debugPrint("Ads Full Screen");
              },
              onAdImpression: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              onAdDismissedFullScreenContent: (ad) async {
                isFullPage.value = false;
                refresh();
                debugPrint("Ads Closed");

                adsCloseOnTap();
              },
              onAdClicked: (ad) {});
        }, onAdFailedToLoad: (err) {
          toastMessage(message: err.message);
          isFullPage.value = false;
          refresh();
        }),
      );
    } catch (err) {
      isFullPage.value = false;
      refresh();
    }
  }

  @override
  void onInit() {
    loadMultipleBannerAds();
    super.onInit();
  }
}
