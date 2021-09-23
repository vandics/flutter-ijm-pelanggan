import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/image/image_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/personal/personal_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/product/product_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/helpers/modaladdcartsucces.dart';
import 'package:mobile_app_ijm_pelanggan/models/productmodels.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/buttonnavigation.dart';
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

  Future getImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      img = pickedFile.path;
    }
    setState(() {});
  }

  Future getTakeFoto() async {
    var pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      img = pickedFile.path;
    }
    setState(() {});
  }

  String? _chosenSizeTabung;
  String? _chosenNumberTabung;
  List _refillMenu = ["0,5m\u00B3", '1m\u00B3', '2m\u00B3', '6m\u00B3'];
  List _banyakTabung = ["1", '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<PersonalBloc, PersonalInformationState>(
      builder: (context, personalstate) => Container(
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
                  'Refill/Isi Ulang',
                  style: GoogleFonts.poppins(
                    fontSize: 25.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                menuUkuranTabung(context),
                SizedBox(
                  height: 25.h,
                ),
                menuBanyakTabung(context),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  width: double.infinity,
                  height: 450.h,
                  padding: EdgeInsets.only(top: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _chosenSizeTabung == null || _chosenNumberTabung == null
                            ? 'Kamu belum buat pilihan'
                            : 'Pesanan kamu tabung dengan ukuran $_chosenSizeTabung sebanyak $_chosenNumberTabung tabung\n\nSilahkan tambahkan foto tabung anda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 220.h,
                        width: 220.w,
                        color: Colors.grey,
                        child: GestureDetector(
                          onTap: () {
                            if (img.isEmpty == true &&
                                _chosenSizeTabung != null &&
                                _chosenNumberTabung != null) {
                              uploadImage(
                                context,
                                'Refill Tabung $_chosenSizeTabung',
                                personalstate.nama,
                              );
                            } else {
                              null;
                            }
                          },
                          child: img.isEmpty
                              ? Text(
                                  'Ketuk untuk upload foto',
                                  style: TextStyle(fontSize: 15.sp),
                                  textAlign: TextAlign.center,
                                )
                              : Image.file(
                                  File(img),
                                  width: 220.w,
                                  height: 220.h,
                                ),
                        ),
                      ),
                      Spacer(),
                      ButtonNavigation(
                          text: 'Pesan',
                          press: _chosenNumberTabung != null &&
                                  _chosenSizeTabung != null &&
                                  img.isNotEmpty
                              ? () async {
                                  BlocProvider.of<ImageBloc>(context).add(
                                      UploadImageTabungEvent(
                                          image: img,
                                          namaTabung:
                                              'Refill Tabung $_chosenSizeTabung',
                                          status: 'Jaminan',
                                          namaUser: personalstate.nama));
                                  final productselect = ProductCart(
                                    namaProduk:
                                        'Refill Tabung $_chosenSizeTabung',
                                    price: 45000,
                                    amount: int.parse(_chosenNumberTabung!),
                                    id: 'A',
                                  );
                                  productBloc.add(
                                    AddProductToCart(
                                      product: productselect,
                                      namaProduk:
                                          ' Refill Tabung $_chosenSizeTabung',
                                    ),
                                  );

                                  modalAddCartSuccess(context);

                                  await Future.delayed(Duration(seconds: 2));
                                  Navigator.pop(context);
                                  Navigator.of(context)
                                      .pushNamed('/MenuScreen');
                                }
                              : null),
                      Spacer(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container menuBanyakTabung(BuildContext context) {
    return Container(
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
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: 300.w,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          focusColor: Colors.white,
          value: _chosenNumberTabung,
          iconEnabledColor: Colors.black,
          items: _banyakTabung.map(
            (value) {
              return DropdownMenuItem(
                  child: Row(
                    children: [
                      Text(
                        "Banyaknya Tabung:  $value",
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ],
                  ),
                  value: value);
            },
          ).toList(),
          hint: Text(
            'Pilih Banyaknya Tabung ',
            style: TextStyle(fontSize: 15.sp),
          ),
          onChanged: (value) {
            FocusScope.of(context).unfocus();
            setState(() {
              _chosenNumberTabung = value as String?;
            });
          },
        ),
      ),
    );
  }

  Container menuUkuranTabung(BuildContext context) {
    return Container(
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
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: 300.w,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          focusColor: Colors.white,
          value: _chosenSizeTabung,
          iconEnabledColor: Colors.black,
          items: _refillMenu.map(
            (value) {
              return DropdownMenuItem(
                child: Row(
                  children: [
                    Text(
                      "Ukuran Tabung:  $value",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ],
                ),
                value: value,
              );
            },
          ).toList(),
          hint: Text('Pilih Ukuran Tabung ', style: TextStyle(fontSize: 15.sp)),
          onChanged: (value) {
            FocusScope.of(context).unfocus();
            setState(() {
              _chosenSizeTabung = value as String;
            });
          },
        ),
      ),
    );
  }

  void uploadImage(BuildContext context, String nama, String namaUser) {
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
                  'Upload gambar tabung',
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
                      getImage();
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
                      getTakeFoto();
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
