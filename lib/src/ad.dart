import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';

class FlutterAd extends StatefulWidget {
  const FlutterAd({Key? key}) : super(key: key);

  @override
  State<FlutterAd> createState() => _FlutterAdState();
}

class _FlutterAdState extends State<FlutterAd> {
  final BannerAd myBanner = BannerAd(
    adUnitId: "ca-app-pub-3940256099942544/6300978111",
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );

  @override
  void initState() {
    myBanner.load();
    myAdd;
    super.initState();
  }

  final myAdd = InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print("Add load");
          ad.show();
          // Keep a reference to the ad so you can show it later.
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 7.w,
            )),
      ),
      backgroundColor: Color(0xff5584AC),
      body: SafeArea(
          child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              "assets/ad.png",
              height: 7.h,
              width: 7.w,
            ),
            title: Text("Banner Ads"),
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
              height: 20.h,
              child: AdWidget(
                ad: myBanner,
              )),
          SizedBox(
            height: 5.h,
          ),
          // Padding(
          // padding: EdgeInsets.symmetric(horizontal: 4.w),
          // child: InkWell(
          // onTap: () {
          // showDialog(
          // context: context,
          // builder: (contextr) {
          // return Dialog(
          // child: Container(
          // height: 50.h,
          // child: AdWidget(ad: myAdd),
          // ),
          // );
          // });
          // },
          // child: Container(
          // height: 7.h,
          // width: double.infinity,
          // alignment: Alignment.center,
          // decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(12),
          // color: Color(0xff05595B)),
          // child: Text(
          // "Interstitial Ad",
          // style: TextStyle(
          // fontSize: 18.sp,
          // fontWeight: FontWeight.bold,
          // color: Colors.white),
          // ),
          // ),
          // ),
          // )
        ],
      )),
    );
  }
}
