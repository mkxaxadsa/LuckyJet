import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../consts.dart';

class Tries extends StatelessWidget {
  final int tries;
  const Tries({super.key, required this.tries});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3.sp)),
        color: const Color(0xFF251F4F), // Set the background color
        boxShadow: const [defaultShadow],
      ),
      child: Text(
        '$tries',
        style: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w800),
      ),
    );
  }
}
