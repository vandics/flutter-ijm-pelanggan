import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/product/product_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/helpers/modaladdcartsucces.dart';
import 'package:mobile_app_ijm_pelanggan/models/productmodels.dart';
import 'package:mobile_app_ijm_pelanggan/view/tabungbaruscreen/listitem.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<ProductCart> tabungbaru = [
    ProductCart(
        namaProduk: "${item[0].tabungsize} Baru",
        price: 45000,
        amount: item[0].amount,
        id: 'B'),
    ProductCart(
        namaProduk: "${item[1].tabungsize} Baru",
        price: 45000,
        amount: item[1].amount,
        id: 'B'),
    ProductCart(
        namaProduk: "${item[2].tabungsize} Baru",
        price: 45000,
        amount: item[2].amount,
        id: 'B'),
    ProductCart(
        namaProduk: "${item[3].tabungsize} Baru",
        price: 45000,
        amount: item[3].amount,
        id: 'B'),
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return BlocBuilder<ProductBloc, ProductState>(
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
              children: [
                Text(
                  'Tabung Baru',
                  style: GoogleFonts.poppins(
                    fontSize: 25.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 30.h,
                  ),
                  height: screenHeight * 0.6,
                  child: (GridView.builder(
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30.h,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.25,
                    ),
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.only(top: 5.h, bottom: 3.h),
                      height: 140.h,
                      width: 170.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.45),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            item[index].tabungsize,
                            style: TextStyle(
                                color: darkBlue,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            item[index].tabugprice,
                            style: TextStyle(color: Colors.black45),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (tabungbaru[index].amount > 0) {
                                    setState(() {
                                      tabungbaru[index].amount--;
                                      item[index].amount--;
                                      print(
                                          'Tabung ${tabungbaru[index].namaProduk} sebanyak ${tabungbaru[index].amount}');
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black54, width: 1),
                                  ),
                                  alignment: Alignment.topCenter,
                                  height: 25.h,
                                  width: 25.w,
                                  child: Text(
                                    '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: darkBlue,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  padding: EdgeInsets.only(bottom: 5.h),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Text(
                                  item[index].amount.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    tabungbaru[index].amount++;
                                    item[index].amount++;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  height: 25.h,
                                  width: 25.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black54, width: 1),
                                  ),
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                        color: darkBlue,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  height: 50.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: darkBlue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.45),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      modalAddCartSuccess(context);
                      tabungbaru.forEach((element) {
                        if (element.amount > 0) {
                          productBloc.add(AddProductToCart(
                              namaProduk: "${element.namaProduk}",
                              product: element));
                        }
                      });
                      item.forEach((element) {
                        element.amount = 0;
                      });
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed('/MenuScreen');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Pesan',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
