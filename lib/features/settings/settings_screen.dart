import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lucky_games/features/games/widgets/coins.dart';
import 'package:lucky_games/features/games/widgets/lives.dart';
import 'package:lucky_games/features/games/widgets/settings_item.dart';
import 'package:lucky_games/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../games/widgets/back.dart';
final InAppReview inAppReview = InAppReview.instance;
@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg/bg3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: pixelRatio * 10,
              right: pixelRatio * 10,
              left: pixelRatio * 10,
            ),
            child: Stack(
              children: [
                const Back(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Settings'.toUpperCase(),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Lives(),
                    SizedBox(width: 5),
                    Coins(),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: height / 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SettingsItem(
                          text: 'Privacy Policy',
                          image: 'assets/settings/privacy_policy.png',
                          callback: (_) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GetXScreen(
                                  getx:
                                      'https://docs.google.com/document/d/1-wVoHJ5R7yAxU9lmYWfzSbGim9fTyL1nXixQWeWXMQg/edit?usp=sharing'),
                            ));
                          },
                        ),
                        SizedBox(height: height / 40),
                        SettingsItem(
                          text: 'Terms of use',
                          image: 'assets/settings/terms_of_use.png',
                          callback: (_) {
                             Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GetXScreen(
                                  getx:
                                      'https://docs.google.com/document/d/1nTI9tgb7KAgeLLB2ib1l7nhj1p0bncmkgIsV5-NdH4k/edit?usp=sharing'),
                            ));
                          },
                        ),
                        SizedBox(height: height / 40),
                        SettingsItem(
                          text: 'Rate app',
                          image: 'assets/settings/rate_app.png',
                          callback: (_) {
                            inAppReview.openStoreListing(appStoreId: '6476615245');
                          },
                        ),
                        SizedBox(height: height / 40),
                        SettingsItem(
                          text: 'Support',
                          image: 'assets/settings/support.png',
                          callback: (_) {
                             Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GetXScreen(
                                  getx:
                                      'https://forms.gle/5He2eANpSmSqF3BU7'),
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GetXScreen extends StatefulWidget {
  const GetXScreen({super.key, required this.getx});
  final String getx;

  @override
  State<GetXScreen> createState() => _GetXScreenState();
}

class _GetXScreenState extends State<GetXScreen> {
  var _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            InAppWebView(
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(
                    source:
                        "javascript:(function() { var ele=document.getElementsByClassName('docs-ml-header-item docs-ml-header-drive-link');ele[0].parentNode.removeChild(ele[0]);var footer = document.getelementsbytagname('footer')[0];footer.parentnode.removechild(footer);})()");
              },
              onProgressChanged: (controller, progress) => setState(() {
                _progress = progress;
              }),
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.getx),
              ),
            ),
            if (_progress != 100)
              Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
