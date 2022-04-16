import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/screens/login_screen/login_screen.dart';
import 'package:tech/screens/splash_screen/splash_screen.dart';
import 'package:tech/shared/bloc_observer/bloc_observer.dart';
import 'package:tech/shared/cash_helper.dart';
import 'package:tech/shared/components/const.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';

import 'layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor:Colors.white,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
  uId = CashHelper.getData(key: 'uId');

  runApp( MyApp(uId));
}

class MyApp extends StatelessWidget
{
  final String uId;
   MyApp(this.uId );

  @override
  Widget build(BuildContext context) {

          return BlocProvider(
            create: (context)=>AppCubit()..getProduct()..getCategory(token: uId)..getBanner(token: uId)..getUserData(uId),
            child:BlocConsumer<AppCubit,AppStates>(
            listener: (context,state){},
            builder: (context,state){
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: SplashScreen(),
              );
            },
            )
          );
        }
}


