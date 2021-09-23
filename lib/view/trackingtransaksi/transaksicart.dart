import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/tracking/tracking_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransaksiCart extends StatefulWidget {
  const TransaksiCart({
    Key? key,
    required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;

  @override
  _TransaksiCartState createState() => _TransaksiCartState();
}

class _TransaksiCartState extends State<TransaksiCart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingBloc, TrackingState>(
      builder: (context, trackingstate) => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: trackingstate.products.length,
        itemBuilder: (context, index) {
          return Container(
            width: widget.screenWidth,
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.black38,
                ),
              ),
            ),
            padding: EdgeInsets.only(
                left: 20.w, right: 15.w, bottom: 1.h, top: 15.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54, width: 1),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${trackingstate.products[index].amount}X',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: darkBlue,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 170.w,
                      child: Text(
                        '${trackingstate.products[index].namaProduk}',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Rp. ${trackingstate.products[index].price * trackingstate.products[index].amount}',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: darkBlue),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
