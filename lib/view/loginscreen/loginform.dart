import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController passcontroller;
  final TextEditingController usercontroller;
  String? username;
  String? password;
  final _formKey = GlobalKey<FormState>();

  LoginForm(
      {Key? key, required this.passcontroller, required this.usercontroller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Container(
            height: 152.h,
            width: screenwidth,
            decoration: BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 75.h,
                  width: screenwidth * 0.75,
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
                  width: screenwidth * 0.75,
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
                    if (_formKey.currentState!.validate()) {}
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
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: passcontroller,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 15.h),
        hintText: 'Password',
        prefixIcon: Opacity(
            opacity: 0.5, child: Icon(Icons.lock, color: Colors.black87)),
      ),
    );
  }

  TextFormField buildUsername() {
    return TextFormField(
      controller: usercontroller,
      autofocus: false,
      maxLines: 5,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 28.h),
        hintText: 'Username',
        prefixIcon: Opacity(
          opacity: 0.5,
          child: Icon(Icons.people, color: Colors.black87),
        ),
      ),
    );
  }
}
