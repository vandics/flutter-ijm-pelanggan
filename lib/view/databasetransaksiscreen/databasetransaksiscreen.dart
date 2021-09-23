import 'package:flutter/material.dart';
import 'package:mobile_app_ijm_pelanggan/view/databasetransaksiscreen/body.dart';

class DataBaseTransaksiScreen extends StatelessWidget {
  const DataBaseTransaksiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
