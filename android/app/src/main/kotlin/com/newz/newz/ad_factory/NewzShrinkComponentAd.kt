package com.newz.newz.ad_factory

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import com.newz.newz.R
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class NewzShrinkComponentAd(
    private val context: Context
) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd, customOptions: Map<String?, Any?>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context).inflate(R.layout.newz_shrink_component_ad_layout, null) as NativeAdView
        val attributionViewSmall: TextView = nativeAdView.findViewById(R.id.tv_list_tile_native_ad_attribution_small)
        val attributionViewLarge: TextView = nativeAdView.findViewById(R.id.tv_list_tile_native_ad_attribution_large)
        val iconView: ImageView = nativeAdView.findViewById(R.id.iv_list_tile_native_ad_icon)
        val icon = nativeAd.icon
        if (icon != null) {
            attributionViewSmall.setVisibility(View.VISIBLE)
            attributionViewLarge.setVisibility(View.INVISIBLE)
            iconView.setImageDrawable(icon.getDrawable())
        } else {
            attributionViewSmall.setVisibility(View.INVISIBLE)
            attributionViewLarge.setVisibility(View.VISIBLE)
        }
        nativeAdView.iconView = iconView
        val headlineView: TextView = nativeAdView.findViewById(R.id.tv_list_tile_native_ad_headline)
        headlineView.setText(nativeAd.getHeadline())
        nativeAdView.headlineView = headlineView
        val bodyView: TextView = nativeAdView.findViewById(R.id.tv_list_tile_native_ad_body)
        bodyView.setText(nativeAd.getBody())
        bodyView.setVisibility(if (nativeAd.getBody() != null) View.VISIBLE else View.INVISIBLE)
        nativeAdView.bodyView = bodyView
        nativeAdView.setNativeAd(nativeAd)
        return nativeAdView
    }
}