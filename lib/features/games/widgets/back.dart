import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Back extends StatelessWidget {
  const Back({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pop(),
      child: FittedBox(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.sp)),
            color: const Color(0xFF251F4F), // Set the background color
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 4),
                blurRadius: 5.5,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(children: [
            Transform.rotate(
              angle: pi,
              child: SvgPicture.asset('assets/onboarding/arrow.svg'),
            ),
            Text(
              'Back',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ]),
        ),
      ),
    );
  }
}
