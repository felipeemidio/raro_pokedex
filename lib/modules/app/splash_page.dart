import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raro_pokedex/core/consts/app_images.dart';

class SplashPage extends StatelessWidget {
  late final Timer timer;

  SplashPage({super.key}) {
    timer = Timer(const Duration(seconds: 5), _redirect);
  }

  _redirect() {
    Modular.to.pushReplacementNamed('login/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.appLogo,
          width: 200.w,
          height: 200.h,
        ),
      ),
    );
  }
}
