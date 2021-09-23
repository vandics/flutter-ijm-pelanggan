import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/auth/auth_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/database/database_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/image/image_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/personal/personal_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/product/product_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/tracking/tracking_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/helpers/preload_image.dart';
import 'package:mobile_app_ijm_pelanggan/helpers/sharedpreferences.dart';
import 'package:mobile_app_ijm_pelanggan/routes/routes.dart';
import 'package:one_context/one_context.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NumReqPreferences.init();
  await loadImage(AssetImage('assets/images/illustrasi b 1.png'));
  await SentryFlutter.init(
      (options) => options.dsn =
          'https://ffa0850df9af458eb8f48c81386d745c@o1003856.ingest.sentry.io/5964628',
      appRunner: () => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => PersonalBloc()),
        BlocProvider(create: (context) => PersonalOrderBloc()),
        BlocProvider(create: (context) => TrackingBloc()),
        BlocProvider(create: (context) => DatabaseBloc()),
        BlocProvider(create: (context) => ImageBloc()),
      ],
      child: ScreenUtilInit(
        designSize: Size(412, 820),
        builder: () => MaterialApp(
          navigatorKey: OneContext().navigator.key,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: "Mobile Aplikasi IMJ (Pelanggan)",
          initialRoute: "/SplashScreen",
          routes: routes,
        ),
      ),
    );
  }
}
