import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class DetailSignUpForm extends StatefulWidget {
  const DetailSignUpForm({Key? key}) : super(key: key);

  @override
  _DetailSignUpFormState createState() => _DetailSignUpFormState();
}

class _DetailSignUpFormState extends State<DetailSignUpForm> {
  String? nama, noidentitas;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildName(),
        SizedBox(
          height: 15.h,
        ),
        buildUsername(),
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
        buildPassword(),
        SizedBox(
          height: 15.h,
        ),
        buildConfrmPass(),
        SizedBox(
          height: 10.h,
        )
      ],
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
        onSaved: (newValue) => nama = newValue,
        enabled: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 13, left: 10.h, right: 10.h),
            child: Text('Konfirmasi Password :'),
          ),
        ),
      ),
    );
  }

  Container buildConfrmPass() {
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
        onSaved: (newValue) => nama = newValue,
        enabled: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 13, left: 10.h, right: 10.h),
            child: Text('Konfirmasi Password :'),
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
        onSaved: (newValue) => nama = newValue,
        enabled: true,
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
        onSaved: (newValue) => nama = newValue,
        enabled: true,
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
          onSaved: (newValue) => nama = newValue,
          enabled: true,
          validator: Validators.compose(
            [
              Validators.required('Password tidak boleh kosong'),
              Validators.minLength(5, 'Password minimal 5'),
              Validators.maxLength(12, 'Password maksimal 12')
            ],
          ),
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
          onSaved: (newValue) => nama = newValue,
          enabled: true,
          validator: Validators.compose(
            [
              Validators.required('Username tidak boleh kosong'),
              Validators.minLength(5, 'Password minimal 5'),
              Validators.maxLength(12, 'Password maksimal 12')
            ],
          ),
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
          onSaved: (newValue) => nama = newValue,
          enabled: true,
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
