import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raro_pokedex/core/consts/app_images.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  _handleLogin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 48.h),
              Image.asset(
                AppImages.appLogo,
                width: 100.w,
                height: 60.h,
              ),
              SizedBox(height: 48.h),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Username'),
                  ),
                  SizedBox(height: 12.h),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Login'),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
