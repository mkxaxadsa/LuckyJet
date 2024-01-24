import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'gradient_text.dart';

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientText(
          text: "JET",
          gradient: const LinearGradient(colors: [
            Color(0xFFC94AF6),
            Color(0xFF662AFB),
          ]),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 32.5.sp,
                fontWeight: FontWeight.w800,
              ),
        ),
        Text(
          'GAMES',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 32.5.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white),
        )
      ],
    );
  }
}
