import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void modalLoading(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white60,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Container(
          height: 90.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Color(0xff006cF2),
                  ),
                  SizedBox(width: 10.h),
                  Text(
                    message,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
