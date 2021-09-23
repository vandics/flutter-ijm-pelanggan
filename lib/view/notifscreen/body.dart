import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/tracking/tracking_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/view/notifscreen/notiflist.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';

class Body extends StatelessWidget {
  final int value;
  final String nama;
  const Body({Key? key, required this.value, required this.nama})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<TrackingBloc, TrackingState>(
      builder: (context, state) => Container(
        width: screenWidth,
        height: screenHeight,
        padding: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 20.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [darkBlue, lightBlue, limeBlue],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  state.nama.isNotEmpty ? 'Hai, ${state.nama}' : 'Hai, $nama',
                  style: GoogleFonts.poppins(
                    fontSize: 23.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                NotifWidget(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  notif: notif[value],
                  image: notif[value].image,
                  description: notif[value].description,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotifWidget extends StatelessWidget {
  final Notifikasi notif;
  NotifWidget(
      {Key? key,
      required this.screenWidth,
      required this.screenHeight,
      required this.notif,
      required this.image,
      required this.description})
      : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final String image;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp, color: Colors.black45),
          ),
          SizedBox(height: 50.h),
          Image.asset(
            image,
            height: 350.h,
            width: screenWidth * 0.8,
          )
        ],
      ),
    );
  }
}
