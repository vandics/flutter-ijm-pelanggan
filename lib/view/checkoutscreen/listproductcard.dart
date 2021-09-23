import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/personal/personal_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/product/product_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';

class ListProductCard extends StatefulWidget {
  const ListProductCard({Key? key}) : super(key: key);

  @override
  ListProductCardState createState() => ListProductCardState();
}

class ListProductCardState extends State<ListProductCard> {
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) =>
          BlocBuilder<PersonalBloc, PersonalInformationState>(
        builder: (context, personalstate) => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            return Container(
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
              padding: EdgeInsets.only(
                left: 10.w,
                right: 5.w,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          productBloc.add(
                            DeleteProductFromCart(
                              index: index,
                              namaUser: personalstate.nama,
                            ),
                          );
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.black,
                          size: 20.h,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54, width: 1),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${state.products[index].amount}X',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: darkBlue,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                        width: 190.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${state.products[index].namaProduk}',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (state.products[index].amount >= 1) {
                                      productBloc.add(
                                        SubtractQuantityProduct(
                                          subtract: index,
                                          namaUser: personalstate.nama,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    '-',
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 19.sp),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    productBloc.add(
                                      PlusQuantityProduct(
                                        plus: index,
                                        namaUser: personalstate.nama,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '+',
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 19.sp),
                                  ),
                                ),
                                SizedBox(width: 20.w),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Rp. ${state.products[index].price * state.products[index].amount}',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
