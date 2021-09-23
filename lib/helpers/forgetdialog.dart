import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void forgotdialog(BuildContext context, TextEditingController controller) {
  Widget cancelButton = TextButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text(
      'Batal',
      style: TextStyle(fontSize: 15.sp),
    ),
  );

  Widget keluarButton = TextButton(
    onPressed: () {},
    child: Text(
      'Masukkan',
      style: TextStyle(fontSize: 15.sp),
    ),
  );

  AlertDialog alert = AlertDialog(
    title: Text(
      'Lupa kata sandi?',
      style: TextStyle(fontSize: 17.sp),
    ),
    content: TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: "masukkan username", hintStyle: TextStyle(fontSize: 13.sp)),
    ),
    actions: [cancelButton, keluarButton],
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
