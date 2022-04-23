import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tech/layout/home_layout.dart';
import 'package:tech/screens/login_screen/login_screen.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/components/const.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    AppCubit.get(context).getProduct();
    Widget widget;
    if(uId==null){
      widget = LoginScreen();
    }else{
      widget =HomeLayout();
    }
    super.initState();
    Timer(const Duration(seconds:3),(){
    navegatToAndFinsh(context,widget);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
              Expanded(
                flex: 1,
                child: Container(
                  height: 240,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:  AssetImage('assets/images/logo.png'),
                      ),
                    )
                  ),
              ),
              const CircularProgressIndicator(
                 valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
               ),
           const SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}
