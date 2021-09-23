import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app_ijm_pelanggan/view/loginscreen/body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillpop() async {
      return await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: Text(
            'Halo',
            style: TextStyle(fontSize: 20.sp),
          ),
          content: Text('Apakah kamu yakin ingin menutup aplikasi?',
              style: TextStyle(fontSize: 15.sp)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Batal',
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: Text(
                'Keluar',
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () => onWillpop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Body(),
      ),
    );
  }
}
