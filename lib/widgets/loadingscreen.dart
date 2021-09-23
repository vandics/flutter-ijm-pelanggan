import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/bloc/auth/auth_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogInState) {
          Navigator.pushNamed(context, '/MenuScreen');
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xff1E4DD8),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(15.0),
            height: 120,
            width: 280,
            decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 15.0),
                    Text(
                      'Sedang masuk',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
