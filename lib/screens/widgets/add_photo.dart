import 'package:flutter/material.dart';

class AddPhoto extends StatelessWidget {
  const AddPhoto({
    super.key,
    this.w = 30,
    this.h = 30,
    this.onTap,
    this.widget,
  });

  final double? w;
  final double? h;
  final VoidCallback? onTap;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      // splashColor: Colors.white,
      // radius: 10,
      onTap: onTap,
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.red,
              offset: Offset(0, 5),
              blurRadius: 10,
            ),
          ],
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.8),
          border: Border.all(width: 3, color: Colors.blue),
        ),
        child: widget,
      ),
    );
  }
}
