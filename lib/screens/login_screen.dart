import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/service/firebase_auth_service.dart';

class LoginScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade900,
        surfaceTintColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                User? user = await _auth.signInWithGoogle();
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: Stack(
                children: [
                  Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.blue.shade500,
                      ),
                      child: Center(
                          child: Text(
                        'Sign in with Google',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold
                            ),
                      ))),
                  Positioned(
                    left: 25.w,
                    top: 15.h,
                    child: Image.network(
                      "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png",
                      height: 40.h,
                      alignment: Alignment.centerLeft,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                Navigator.pushReplacementNamed(context, '/phone');
              },
              child: Stack(
                children: [
                  Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green,
                      ),
                      child: Center(
                          child: Text(
                        'Sign in with Phone',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold
                            ),
                      ))),
                  Positioned(
                    left: 35.w,
                    top: 25.h,
                    child: Image.network(
                      "https://pngimg.com/d/phone_PNG48972.png",
                      height: 25.h,
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
