import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/auth/auth_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/helpers/modalloading.dart';
import 'package:mobile_app_ijm_pelanggan/helpers/modalsucces.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/buttonnavigation.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _namaController = TextEditingController();
  final _usernameController = TextEditingController();
  final _instansiController = TextEditingController();
  final _telponController = TextEditingController();
  final _alamatController = TextEditingController();
  final _passwordController = TextEditingController();
  bool? accPrivacy = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _instansiController.dispose();
    _telponController.dispose();
    _alamatController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingRegisterState) {
          modalLoading(context, 'Sedang membuat akun...');
        } else if (state is RegisterSuccess) {
          Navigator.of(context).pop();
          modalSuccess(context, 'User Berhasil dibuat');
        } else if (state is FailureRegisterState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: TextStyle(fontSize: 15),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Container(
          width: screenWidth,
          height: screenHeight,
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
              child: Padding(
                padding: EdgeInsets.all(15.h),
                child: Column(
                  children: [
                    Text(
                      'Daftar',
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
                      width: double.infinity,
                      height: screenHeight * 0.79,
                      padding: EdgeInsets.only(top: 40.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              buildName(),
                              SizedBox(
                                height: 15.h,
                              ),
                              buildUsername(),
                              SizedBox(
                                height: 15.h,
                              ),
                              buildPassword(),
                              SizedBox(
                                height: 15.h,
                              ),
                              buildInstansi(),
                              SizedBox(
                                height: 15.h,
                              ),
                              buildNoHpWa(),
                              SizedBox(
                                height: 15.h,
                              ),
                              buildalamat(),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: accPrivacy,
                                  onChanged: (value) {
                                    setState(() {
                                      accPrivacy = value;
                                    });
                                  },
                                ),
                                Container(
                                  width: 300.w,
                                  height: 50.h,
                                  child: Text(
                                    'Data yang kamu masukkan kami gunakan untuk kepentingan perusahaan dan akan kami jaga kerahasiaannya. Centang jika setuju.',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 10.sp),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 70.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ButtonNavigation(
                                  text: 'Daftar',
                                  press: accPrivacy == true
                                      ? () {
                                          authBloc.add(
                                            RegisterEvent(
                                              nama: _namaController.text,
                                              username:
                                                  _usernameController.text,
                                              instansi:
                                                  _instansiController.text,
                                              password:
                                                  _passwordController.text,
                                              telpon: _telponController.text,
                                              alamat: _alamatController.text,
                                            ),
                                          );
                                        }
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildalamat() {
    return Container(
      width: 350.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: TextFormField(
        controller: _alamatController,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 13, left: 10.h, right: 10.h),
            child: Text('Alamat :'),
          ),
        ),
      ),
    );
  }

  Container buildNoHpWa() {
    return Container(
      width: 350.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: _telponController,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 13, left: 10.h, right: 10.h),
            child: Text('No. HP/WA :'),
          ),
        ),
      ),
    );
  }

  Container buildInstansi() {
    return Container(
      width: 350.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: TextFormField(
        controller: _instansiController,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 13, left: 10.h, right: 10.h),
            child: Text('Instansi :'),
          ),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      width: 350.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsets.only(top: 13, left: 10.h, right: 10.h),
              child: Text('Password :'),
            ),
          ),
        ),
      ),
    );
  }

  Container buildUsername() {
    return Container(
      width: 350.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsets.only(top: 13, left: 10.h, right: 10.h),
              child: Text('Username :'),
            ),
          ),
        ),
      ),
    );
  }

  Container buildName() {
    return Container(
      width: 350.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: TextFormField(
          controller: _namaController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsets.only(top: 13, left: 10.h, right: 10.h),
              child: Text('Nama :'),
            ),
          ),
        ),
      ),
    );
  }
}
