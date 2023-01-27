import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:newz/feature/ads/util/AdHelperUtil.dart';
import 'package:skeletons/skeletons.dart';

class NewzShrinkComponentAdView extends StatefulWidget {
  const NewzShrinkComponentAdView({Key? key}) : super(key: key);

  @override
  State<NewzShrinkComponentAdView> createState() =>
      _NewzShrinkComponentAdViewState();
}

class _NewzShrinkComponentAdViewState extends State<NewzShrinkComponentAdView> {
  NativeAd? _ad;

  @override
  Widget build(BuildContext context) {
    return _ad == null
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
            child: Container(
              height: 81,
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(30, 11, 15, 53),
                    blurRadius: 10,
                    offset: Offset(1, 3), // changes position of shadow
                  ),
                ],
              ),
              child: SkeletonListTile(hasSubtitle: true,),
            ),
          )
        : Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
            child: Container(
              height: 81,
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(30, 11, 15, 53),
                    blurRadius: 10,
                    offset: Offset(1, 3), // changes position of shadow
                  ),
                ],
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
      factoryId: "NewzShrinkComponentAd",
      request: const AdRequest(),
      listener: NativeAdListener(onAdLoaded: (responseAd) {
        setState(() {
          _ad = responseAd as NativeAd;
        });
      }, onAdFailedToLoad: (responseAd, loadAdError) {
        print(
            "error code : ${loadAdError.code}, error message : ${loadAdError.message}");
      }),
    ).load();
  }
}
