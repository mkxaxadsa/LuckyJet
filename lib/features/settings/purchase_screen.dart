import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucky_games/features/games/widgets/back.dart';

@RoutePage()
class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

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
            image: AssetImage('assets/bg/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(pixelRatio * 10),
            child: Stack(
              children: [
                const Back(),
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset('assets/shared/logo.svg'),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Purchase Lives',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                              ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
