import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void modalSuccess(BuildContext context, String title) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
        content: Container(
          alignment: Alignment.center,
          height: 275.h,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Icon(Icons.check_circle_outline_outlined,
                  size: 180, color: Colors.green),
              TextButton(
                  child: Text('Berhasil dibuat',
                      style: TextStyle(fontSize: 17.sp)),
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed('/LoginScreen'))
            ],
          ),
        ),
      );
    },
  );
}
