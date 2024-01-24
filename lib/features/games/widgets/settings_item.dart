import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsItem extends StatelessWidget {
  final String text;
  final String image;
  final Function(dynamic) callback;

  const SettingsItem(
      {super.key,
      required this.text,
      required this.image,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback('Argument'),
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.sp)),
          color: const Color(0xFF251F4F),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 4),
              blurRadius: 5.5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(image),
            const SizedBox(width: 10),
            Text(
              text,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
