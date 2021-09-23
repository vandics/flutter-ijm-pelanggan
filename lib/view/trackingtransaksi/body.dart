import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/image/image_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/personal/personal_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/tracking/tracking_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/helpers/loadingupload.dart';
import 'package:mobile_app_ijm_pelanggan/view/notifscreen/notifscreen.dart';
import 'package:mobile_app_ijm_pelanggan/view/trackingtransaksi/transaksicart.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? image;
  String img = '';
  final picker = ImagePicker();

  Future getImage(String rwo, String nama, String nomor) async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      img = pickedFile.path;
      BlocProvider.of<ImageBloc>(context).add(UploadImageTransactionEvent(
          image: img, rwo: rwo, nama: nama, nomor: nomor));
    }
    setState(() {});
  }

  Future getTakeFoto(String rwo, String nama, String nomor) async {
    var pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      img = pickedFile.path;
      BlocProvider.of<ImageBloc>(context).add(UploadImageTransactionEvent(
          image: img, rwo: rwo, nama: nama, nomor: nomor));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final trackingBloc = BlocProvider.of<TrackingBloc>(context);
    return BlocBuilder<TrackingBloc, TrackingState>(
      builder: (context, trackingstate) => MultiBlocListener(
        listeners: [
          BlocListener<TrackingBloc, TrackingState>(
            listener: (context, state) {
              if (state is ProcessState && state is TrackingState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotifScreen(
                      index: 1,
                      nama: '',
                    ),
                  ),
                );
              } else if (state is FillState && state is TrackingState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotifScreen(
                      index: 2,
                      nama: '',
                    ),
                  ),
                );
              } else if (state is ReadyState && state is TrackingState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotifScreen(
                      index: 3,
                      nama: '',
                    ),
                  ),
                );
              } else if (state is DeliveryState && state is TrackingState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotifScreen(
                      index: 4,
                      nama: '',
                    ),
                  ),
                );
              }
            },
          ),
          BlocListener<ImageBloc, ImageState>(listener: (context, state) {
            if (state is LoadingUploadImageState) {
              loadingUploadFile(context);
            } else if (state is UploadImageSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Berhasil diupload',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
              );
            }
          })
        ],
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            padding: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 5.h),
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
                      'Transaksi sedang Berjalan',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20.h),
                          width: screenWidth,
                          height: screenHeight * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              TransaksiCart(screenWidth: screenWidth),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: 25.w, right: 10.w),
                                height: 70.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TOTAL',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp,
                                          color: darkBlue),
                                    ),
                                    Text(
                                      'Rp. ${trackingstate.total}',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp,
                                          color: darkBlue),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 100.h,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: screenWidth * 0.93,
                            color: Colors.white,
                            height: 70.h,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: darkBlue,
                                  ),
                                  child: BlocBuilder<PersonalBloc,
                                      PersonalInformationState>(
                                    builder: (context, personalstate) =>
                                        ElevatedButton(
                                      onPressed: () {
                                        print(trackingstate.status);
                                        trackingstate.products.length != 0
                                            ? trackingBloc.add(
                                                TrackingNotificationEvent(
                                                    nama: trackingstate.nama,
                                                    rwo: trackingstate.rwo),
                                              )
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NotifScreen(
                                                          index: 0,
                                                          nama: personalstate
                                                              .nama),
                                                ),
                                              );
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Cek pesanan sekarang',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  height: 50.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: darkBlue,
                                  ),
                                  child: BlocBuilder<PersonalBloc,
                                      PersonalInformationState>(
                                    builder: (context, personalstate) =>
                                        ElevatedButton(
                                      onPressed:
                                          trackingstate.products.length == 0 ||
                                                  trackingstate.status ==
                                                      'Lunas'
                                              ? null
                                              : () {
                                                  uploadImage(
                                                      context,
                                                      trackingstate.rwo,
                                                      personalstate.nama,
                                                      personalstate.numreq
                                                          .toString());
                                                },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Upload bukti transaksi',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.h,
                            width: screenWidth * 0.93,
                            color: Colors.white,
                            child: Text(
                              trackingstate.rwo,
                              style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void uploadImage(
      BuildContext context, String rwo, String nama, String nomor) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      context: context,
      isDismissible: true,
      builder: (context) {
        return Container(
          height: 190.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25.w, top: 25.h),
                child: Text(
                  'Upload bukti transaksi',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 0,
                  child: InkWell(
                    onTap: () {
                      getImage(rwo, nama, nomor);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 22.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ambil gambar dari galeri',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 0,
                  child: InkWell(
                    onTap: () {
                      getTakeFoto(rwo, nama, nomor);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 22.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ambil gambar dari foto',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
