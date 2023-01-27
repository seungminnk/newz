package com.newz.newz

import com.newz.newz.ad_factory.NewzComponentAd
import com.newz.newz.ad_factory.NewzShrinkComponentAd
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "NewzComponentAd", NewzComponentAd(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "NewzShrinkComponentAd", NewzShrinkComponentAd(context))
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "NewzComponentAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "NewzShrinkComponentAd")
    }
}
