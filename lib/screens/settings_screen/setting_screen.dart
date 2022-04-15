import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/screens/login_screen/login_screen.dart';
import 'package:tech/screens/update_profile_screen/update_profile.dart';
import 'package:tech/shared/cash_helper.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/components/const.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';
import 'package:tech/shared/styles/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var pass = TextEditingController();
  var address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
      var  c=AppCubit.get(context);
          return Center(
              child:SafeArea(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        c.currentIndex=0;
                        navegatToAndFinsh(context, LoginScreen()).then((value) {
                          c.signOut();
                          CashHelper.removeData(key: uId);
                        });
                      },
                      child: const Text('logOut'),
                    ),
                    TextButton(
                      onPressed: () {
                       navegatTo(context, UpdateProfile());
                      },
                      child: const Text('update'),
                    )

                  ],
                ),
              )
          );
      },
    );
  }
}

