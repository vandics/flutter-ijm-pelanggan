import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/database/database_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/personal/personal_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/tracking/tracking_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/models/productmodels.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final columns = ['No.RWO', 'Status Transaksi', 'Lampiran'];
  final rows = [''];
  List<dynamic> product = [];
  List<ProductCart> productcart = [];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final trackingBloc = BlocProvider.of<TrackingBloc>(context);
    return BlocBuilder<PersonalBloc, PersonalInformationState>(
      builder: (context, personalstate) =>
          BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) => Container(
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
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Text(
                    'Data Transaksi',
                    style: GoogleFonts.poppins(
                      fontSize: 25.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.h),
                    width: screenWidth,
                    height: screenHeight * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: getColoumn(columns),
                          rows: state.history.length != 0
                              ? state.history
                                  .map(
                                    (e) => DataRow(
                                      cells: [
                                        DataCell(Text("${e.rwo}")),
                                        DataCell(Text("${e.statustransaksi}")),
                                        DataCell(
                                          IconButton(
                                            onPressed: e.statustransaksi !=
                                                    'Lunas'
                                                ? () {
                                                    if (product.length != 0 &&
                                                        productcart.length !=
                                                            0) {
                                                      product.clear();
                                                      productcart.clear();
                                                    }
                                                    product = (jsonDecode(
                                                        e.productcart));

                                                    for (int i = 0;
                                                        i < product.length;
                                                        i++) {
                                                      productcart.add(
                                                        ProductCart(
                                                            namaProduk:
                                                                product[i]
                                                                    ["nama"],
                                                            price: product[i]
                                                                ["price"],
                                                            amount: product[i]
                                                                ["amount"],
                                                            id: 'V'),
                                                      );
                                                    }
                                                    trackingBloc.add(
                                                      AddProductToTrackingEvent(
                                                        status:
                                                            e.statustransaksi,
                                                        rwo: e.rwo,
                                                        nama:
                                                            personalstate.nama,
                                                        product: productcart,
                                                      ),
                                                    );
                                                    Navigator.pushNamed(context,
                                                        '/TrackingTransaksi');
                                                  }
                                                : null,
                                            icon: Icon(Icons.task),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                  .toList()
                              : rows
                                  .map(
                                    (e) => DataRow(
                                      cells: [
                                        DataCell(Text("belum ada data")),
                                        DataCell(Text("belum ada data")),
                                        DataCell(
                                          IconButton(
                                            onPressed: null,
                                            icon: Icon(Icons.task),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> getColoumn(List<String> columns) => columns
      .map(
        (String column) => DataColumn(
          label: Text(column),
        ),
      )
      .toList();
}
