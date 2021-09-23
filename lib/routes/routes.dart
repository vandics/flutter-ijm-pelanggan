import 'package:flutter/widgets.dart';
import 'package:mobile_app_ijm_pelanggan/view/checkoutscreen/checkoutscreen.dart';
import 'package:mobile_app_ijm_pelanggan/view/databasetransaksiscreen/databasetransaksiscreen.dart';
import 'package:mobile_app_ijm_pelanggan/view/loginscreen/loginscreen.dart';
import 'package:mobile_app_ijm_pelanggan/view/menuscreen/menuscreen.dart';
import 'package:mobile_app_ijm_pelanggan/view/pinjamtabungscreen/pinjamtabungscreen.dart';
import 'package:mobile_app_ijm_pelanggan/view/refillscreen/refillscreen.dart';
import 'package:mobile_app_ijm_pelanggan/view/signupscreen/signupscreen.dart';
import 'package:mobile_app_ijm_pelanggan/view/splashscreen/splashscreen.dart';
import 'package:mobile_app_ijm_pelanggan/view/tabungbaruscreen/tabungbaruscreen.dart';
import 'package:mobile_app_ijm_pelanggan/view/trackingtransaksi/trackingtransaksi.dart';
import 'package:mobile_app_ijm_pelanggan/view/transaksiscreen/transaksiscreen.dart';

Map<String, Widget Function(BuildContext context)> routes = {
  '/SplashScreen': (context) => SplashScreen(),
  '/LoginScreen': (context) => LoginScreen(),
  '/SignupScreen': (context) => SignUpScreen(),
  '/MenuScreen': (context) => MenuScreen(),
  '/RefillScreen': (context) => RefillScreen(),
  '/TabungbaruScreen': (context) => TabungBaruScreen(),
  '/PinjamTabungScreen': (context) => PinjamTabungScreen(),
  '/CheckoutScreen': (context) => CheckoutScreen(),
  '/TransaksiScreen': (context) => TransaksiScreen(),
  '/TrackingTransaksi': (context) => TrackingTransaksi(),
  '/DataBaseTransaksi': (context) => DataBaseTransaksiScreen()
};
