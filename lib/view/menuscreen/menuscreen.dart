import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/personal/personal_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/product/product_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/helpers/logoutdialog.dart';
import 'package:mobile_app_ijm_pelanggan/view/menuscreen/itemmenu.dart';
import 'package:mobile_app_ijm_pelanggan/view/menuscreen/menulist.dart';
import 'package:mobile_app_ijm_pelanggan/widgets/constants.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future<bool> onWillpop(String title) async {
    return await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text(
          'Halo, $title',
          style: TextStyle(fontSize: 15.sp),
        ),
        content: Text('Apakah kamu yakin ingin keluar?',
            style: TextStyle(fontSize: 15.sp)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              BlocProvider.of<ProductBloc>(context).add(ClearProductEvent());
            },
            child: Text(
              'Batal',
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              'Keluar',
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final personalBloc = BlocProvider.of<PersonalBloc>(context);
    return BlocBuilder<PersonalBloc, PersonalInformationState>(
      builder: (context, state) => WillPopScope(
        onWillPop: () => onWillpop(state.nama),
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [darkBlue, limeBlue, darkBlue],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      color: Colors.transparent,
                      width: double.infinity,
                      height: 30.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                logOutButton(context, state.nama);
                              },
                              child:
                                  Icon(Icons.people_alt, color: Colors.white)),
                          GestureDetector(
                              onTap: () {
                                personalBloc.add(
                                  PersonalInformationEvent(
                                      username: state.username),
                                );
                                Navigator.pushNamed(context, '/CheckoutScreen');
                              },
                              child: Icon(Icons.shopping_basket,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/illustrasi c 1.png',
                      width: screenWidth,
                      height: 315.h,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.w, 15.h, 10.w, 16.h),
                        child: GridView.builder(
                          itemCount: 4,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) => ItemMenu(
                            menu: menu[index],
                            press: () => Navigator.pushNamed(
                                context, menu[index].navigation),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
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
}
