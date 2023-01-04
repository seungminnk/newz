import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:newz/feature/ads/util/AdHelperUtil.dart';

class NewzComponentAdView extends StatefulWidget {
  const NewzComponentAdView({Key? key}) : super(key: key);

  @override
  State<NewzComponentAdView> createState() => _NewzComponentAdViewState();
}

class _NewzComponentAdViewState extends State<NewzComponentAdView> {

  NativeAd? _ad;

  @override
  Widget build(BuildContext context) {
    return _ad == null ?
      const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(),
        ),
      )
          :
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          height: 360,
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              color: Color.fromARGB(255, 232, 234, 246)
          ),
          child: AdWidget(ad: _ad!),
        ),
      );
  }

  @override
  void initState() {
    super.initState();

    NativeAd(
      adUnitId: AdHelperUtil.nativeAdUnitId,
      factoryId: "NewzComponentAd",
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (responseAd){
          setState(() {
            _ad = responseAd as NativeAd;
          });
        },
        onAdFailedToLoad: (responseAd, loadAdError){
          print("error code : ${loadAdError.code}, error message : ${loadAdError.message}");
        }
      ),
    ).load();
  }
}

