import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/database/database_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/personal/personal_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final historyBloc = BlocProvider.of<DatabaseBloc>(context);
    return BlocBuilder<PersonalBloc, PersonalInformationState>(
      builder: (context, state) => Container(
        width: screenWidth,
        height: screenHeight,
        padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 20.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [darkBlue, lightBlue, limeBlue],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'Menu Transaksi',
                style: GoogleFonts.poppins(
                  fontSize: 25.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 170.h,
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/TrackingTransaksi"),
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.8,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Transaksi Sedang Berjalan',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      color: darkBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  historyBloc.add(HistoryEvent(nama: state.nama));
                  Navigator.of(context).pushNamed('/DataBaseTransaksi');
                },
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.8,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Transaksi Selesai',
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      color: darkBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
