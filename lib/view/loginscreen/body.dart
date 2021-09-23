import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/auth/auth_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/personal/personal_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/helpers/modalloading.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController userController = TextEditingController();
  TextEditingController passowrdController = TextEditingController();
  TextEditingController forgotpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String pass = '';

  @override
  void dispose() {
    super.dispose();
    passowrdController.dispose();
    userController.dispose();
    forgotpasswordController.dispose();
  }

  getProgressDialog() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final personalBloc = BlocProvider.of<PersonalBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is LoadingState) {
          modalLoading(context, 'Sedang masuk ....');
        } else if (state is FailureState) {
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
        } else if (state is LogInState) {
          personalBloc
              .add(PersonalInformationEvent(username: userController.text));
          await Future.delayed(Duration(seconds: 7));
          Navigator.pushReplacementNamed(context, '/MenuScreen');
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: 240.h,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage('assets/images/Bentuk 2 (1).png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    child: Opacity(
                      opacity: 0.5,
                      child: Container(
                        height: 250.h,
                        width: screenWidth * 0.94,
                        child: Image(
                          image: AssetImage('assets/images/Bentuk 2 (1).png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.2,
                    left: 50.w,
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontFamily: 'AnjaEliane', fontSize: 50.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            Form(
              key: _formKey,
              child: Stack(
                children: [
                  Container(
                    height: 152.h,
                    width: screenWidth,
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 75.h,
                          width: screenWidth * 0.75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                              topRight: Radius.circular(70),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                          child: buildUsername(),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Container(
                          height: 75.h,
                          width: screenWidth * 0.75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                              bottomRight: Radius.circular(70),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 6),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: buildPassword(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 35.h,
                    right: 55.w,
                    child: Container(
                      height: 80.h,
                      width: 75.w,
                      child: FittedBox(
                        child: FloatingActionButton(
                          onPressed: () {
                            if (userController.text.isNotEmpty &&
                                passowrdController.text.isNotEmpty) {
                              authBloc.add(
                                LoginEvent(
                                    username: userController.text,
                                    password: passowrdController.text),
                              );
                              setSharedPass(
                                  userController.text, passowrdController.text);
                            } else if (userController.text.isEmpty ||
                                passowrdController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'username/password tidak boleh kosong',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 80.h,
                            width: 75.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // circular shape
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomRight,
                                colors: [
                                  lightBlue,
                                  limeBlue,
                                ],
                              ),
                            ),
                            child: Icon(Icons.arrow_forward, size: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 20.w),
                  child: GestureDetector(
                    child: Text(
                      'Buat Akun',
                      style: TextStyle(color: Colors.black54),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/SignupScreen'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 10.w),
                  child: Text(
                    '|',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 10.w),
                  child: GestureDetector(
                    child: Text(
                      'Lupa kata sandi?',
                      style: TextStyle(color: Colors.black54),
                    ),
                    onTap: () {
                      forgotdialog();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.h),
            Container(
              height: 240.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Image.asset('assets/images/Group 24 (3).png')],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: passowrdController,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 12.h),
        hintText: 'Password',
        prefixIcon: Opacity(
            opacity: 0.5, child: Icon(Icons.lock, color: Colors.black87)),
      ),
    );
  }

  TextFormField buildUsername() {
    return TextFormField(
      controller: userController,
      autofocus: false,
      maxLines: 5,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 25.h),
        hintText: 'Username',
        prefixIcon: Opacity(
          opacity: 0.5,
          child: Icon(Icons.people, color: Colors.black87),
        ),
      ),
    );
  }

  void setSharedPass(String user, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(user, pass);
  }

  void getSharedPass(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      pass = prefs.getString(user) ?? '';
    });
  }

  void forgotdialog() {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: pass.isEmpty
          ? Text(
              'Batal',
              style: TextStyle(fontSize: 15.sp),
            )
          : Text(
              'Kembali',
              style: TextStyle(fontSize: 15.sp),
            ),
    );

    Widget keluarButton = TextButton(
      onPressed: pass.isEmpty
          ? () async {
              getSharedPass(forgotpasswordController.text);
              Navigator.of(context).pop();
              Future.delayed(Duration(seconds: 3));
              forgotdialog();
            }
          : () {
              pass = '';
              Navigator.of(context).pop();
            },
      child: pass.isEmpty
          ? Text(
              'Masukkan',
              style: TextStyle(fontSize: 15.sp),
            )
          : Text(
              'OK',
              style: TextStyle(fontSize: 15.sp),
            ),
    );

    AlertDialog alert = AlertDialog(
      title: pass.isEmpty
          ? Text(
              'Lupa kata sandi?',
              style: TextStyle(fontSize: 17.sp),
            )
          : Text(
              'Kata sandi anda',
              style: TextStyle(fontSize: 17.sp),
            ),
      content: pass.isEmpty
          ? TextFormField(
              controller: forgotpasswordController,
              decoration: InputDecoration(
                  hintText: "masukkan username",
                  hintStyle: TextStyle(fontSize: 13.sp)),
            )
          : Text(
              '$pass',
              style: TextStyle(fontSize: 17.sp),
            ),
      actions: [cancelButton, keluarButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
