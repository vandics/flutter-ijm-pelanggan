import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/product/product_bloc.dart';

void logOutButton(BuildContext context, String title) {
  Widget cancelButton = TextButton(
    onPressed: () {
      Navigator.of(context).pop();
      BlocProvider.of<ProductBloc>(context).add(ClearProductEvent());
    },
    child: Text(
      'Batal',
      style: TextStyle(fontSize: 15.sp),
    ),
  );

  Widget keluarButton = TextButton(
    onPressed: () {
      Navigator.pushReplacementNamed(context, '/LoginScreen');
    },
    child: Text(
      'Keluar',
      style: TextStyle(fontSize: 15.sp),
    ),
  );

  AlertDialog alert = AlertDialog(
    title: Text('Halo, $title', style: TextStyle(fontSize: 15.sp)),
    content: Text('Apakah kamu yakin ingin keluar?',
        style: TextStyle(fontSize: 15.sp)),
    actions: [cancelButton, keluarButton],
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
