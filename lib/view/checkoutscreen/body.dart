import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:mobile_app_ijm_pelanggan/bloc/personal/personal_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/product/product_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/tracking/tracking_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/helpers/modaladdcartsucces.dart';
import 'package:mobile_app_ijm_pelanggan/view/checkoutscreen/listproductcard.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String rwo(List id, int sumAmount, String? _chosenPayMethod,
      String? _chosenSendMethod, String nama, var numreq) {
    DateTime datetime = DateTime.now();
    var month = datetime.month.toString();
    var day = datetime.day.toString();
    var noreq = numreq;
    int jumlahtabung = sumAmount;
    String jenismenu = id.join();

    var metodeambil = _chosenSendMethod == 'Dikirim ke alamat' ? 1 : 0; //kirim
    var metodebayar = _chosenPayMethod == 'Transfer' ? 1 : 0; //hutang

    return '$day$month${datetime.year.toString()}/$noreq.$jumlahtabung.$jenismenu.$metodebayar.$metodeambil/$nama';
  }

  String? _chosenPayMethod;
  String? _chosenSendMethod;
  List payMethod = ['Transfer', 'Hutang'];
  List sendMethod = ['Dikirim ke alamat', 'Ambil Sendiri'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orderBloc = BlocProvider.of<PersonalOrderBloc>(context);
    final productBloc = BlocProvider.of<ProductBloc>(context);
    final trackingBloc = BlocProvider.of<TrackingBloc>(context);

    return BlocBuilder<PersonalBloc, PersonalInformationState>(
      builder: (context, personalstate) =>
          BlocListener<PersonalOrderBloc, PersonalOrderState>(
        listener: (context, personalorderstate) async {
          {
            if (personalorderstate is SuccesOrderState) {
              modalAddCartSuccess(context);

              await Future.delayed(Duration(seconds: 2));

              Navigator.of(context).pop();

              sendDataNumReq(
                personalstate.username,
                personalstate.numreq + 1,
              );

              productBloc.add(ClearProductEvent());
            } else if (personalorderstate is FailureOrderState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    personalorderstate.error,
                    style: TextStyle(fontSize: 15),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        child: Container(
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
              child: Column(
                children: [
                  Text(
                    'Ringkasan Pesanan',
                    style: GoogleFonts.poppins(
                      fontSize: 25.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Container(
                      padding: EdgeInsets.only(top: 5.h),
                      height: screenHeight * 0.8,
                      width: screenWidth,
                      color: Colors.white,
                      child: BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, productstate) {
                          return Stack(
                            children: [
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  ListProductCard(),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 25.w, right: 15.w),
                                    width: screenWidth,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Pesanan',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp),
                                        ),
                                        Text(
                                          'Rp. ${productstate.total}',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                              color: darkBlue),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 20.w, right: 15.w),
                                    width: screenWidth,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        focusColor: Colors.white,
                                        value: _chosenSendMethod,
                                        iconEnabledColor: Colors.black,
                                        items: sendMethod.map(
                                          (value) {
                                            return DropdownMenuItem(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Metode Pengiriman:  $value",
                                                      style: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                  ],
                                                ),
                                                value: value);
                                          },
                                        ).toList(),
                                        hint: Text('Pilih Metode Pengiriman ',
                                            style: TextStyle(fontSize: 14.sp)),
                                        onChanged: (value) {
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            _chosenSendMethod =
                                                value as String?;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 25.w, right: 15.w, top: 6.h),
                                    width: screenWidth,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Alamat Pengiriman'),
                                        Text(
                                          '${personalstate.alamat}',
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 25.w, right: 15.w),
                                    width: screenWidth,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Subtotal Produk',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 14.sp),
                                            ),
                                            Text(
                                              'Rp. ${productstate.total}',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 14.sp),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Subtotal Pengiriman',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 14.sp),
                                            ),
                                            Text(
                                              _chosenSendMethod ==
                                                      'Dikirim ke alamat'
                                                  ? 'Rp. 50.000'
                                                  : 'Rp. 0',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 14.sp),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total pembayaran',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              _chosenSendMethod ==
                                                      'Dikirim ke alamat'
                                                  ? 'Rp. ${productstate.total + 50000}'
                                                  : 'Rp. ${productstate.total}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 25.w, right: 15.w),
                                    width: screenWidth,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        focusColor: Colors.white,
                                        value: _chosenPayMethod,
                                        iconEnabledColor: Colors.black,
                                        items: payMethod.map(
                                          (value) {
                                            return DropdownMenuItem(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Metode Pembayaran:  $value",
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                  ),
                                                ],
                                              ),
                                              value: value,
                                            );
                                          },
                                        ).toList(),
                                        hint: Text('Pilih Metode Pembayaran ',
                                            style: TextStyle(fontSize: 14.sp)),
                                        onChanged: (value) {
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            _chosenPayMethod = value as String?;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 70.h,
                                    child: Text(
                                      rwo(
                                        productstate.id.toSet().toList(),
                                        productstate.sumAmount,
                                        _chosenPayMethod,
                                        _chosenSendMethod,
                                        personalstate.nama,
                                        personalstate.numreq + 1,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                  )
                                ],
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: screenWidth,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        spreadRadius: 0,
                                        offset: Offset(0, -2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(
                                            top: 1.h, right: 10.w),
                                        height: 70.h,
                                        width: screenWidth * 0.6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Total Pembayaran',
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            Text(
                                              _chosenSendMethod ==
                                                      'Dikirim ke alamat'
                                                  ? 'Rp. ${productstate.total + 50000}'
                                                  : 'Rp. ${productstate.total}',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: darkBlue,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      BlocBuilder<PersonalOrderBloc,
                                          PersonalOrderState>(
                                        builder: (context, orderState) =>
                                            GestureDetector(
                                          onTap: () async {
                                            if (productstate.products.length !=
                                                0) {
                                              orderBloc.add(
                                                PersonalOrderEvent(
                                                  nama: personalstate.nama,
                                                  norwo: rwo(
                                                    productstate.id
                                                        .toSet()
                                                        .toList(),
                                                    productstate.sumAmount,
                                                    _chosenPayMethod,
                                                    _chosenSendMethod,
                                                    personalstate.nama,
                                                    personalstate.numreq + 1,
                                                  ),
                                                  statusPengisian:
                                                      'Sedang diproses',
                                                  statusTransaksi:
                                                      'Belum Lunas',
                                                  idTabung: '0',
                                                  spesifikasiTabung: '0',
                                                  image: 'o',
                                                  kebutuhan: jsonEncode(
                                                      productstate.products),
                                                  nominal: _chosenSendMethod ==
                                                          'Dikirim ke alamat'
                                                      ? 'Rp. ${productstate.total + 50000}'
                                                      : 'Rp. ${productstate.total}',
                                                ),
                                              );
                                              trackingBloc.add(
                                                AddProductToTrackingEvent(
                                                  nama: personalstate.nama,
                                                  product:
                                                      productstate.products,
                                                  status: 'Sedang diproses',
                                                  rwo: rwo(
                                                    productstate.id
                                                        .toSet()
                                                        .toList(),
                                                    productstate.sumAmount,
                                                    _chosenPayMethod,
                                                    _chosenSendMethod,
                                                    personalstate.nama,
                                                    personalstate.numreq + 1,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Kamu belum belanja apapun',
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left: 9.w),
                                            alignment: Alignment.centerLeft,
                                            color: Colors.blue,
                                            height: 70.h,
                                            width: screenWidth * 0.4,
                                            child: Text(
                                              "Buat Pesanan",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendDataNumReq(String username, int numreq) async {
    var server = 'https://nodeapi.projectkitaid.com/user';
    final body = {'username': username, 'nomor_pesan': numreq};
    await http.post(
      Uri.parse('$server/update-number-req'),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );
  }
}
