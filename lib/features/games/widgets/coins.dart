import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consts.dart';
import '../../../main.dart';

class Coins extends StatelessWidget {
  const Coins({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3.sp)),
        color: const Color(0xFF251F4F), // Set the background color
        boxShadow: const [defaultShadow],
      ),
      child: Row(children: [
        Image.asset('assets/shared/coins.png'),
        Text(
          locator<SharedPreferences>().getInt('coins').toString(),
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 8.sp, fontWeight: FontWeight.w600),
        ),
      ]),
    );
  }
}
