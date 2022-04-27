import 'package:cached_network_image/cached_network_image.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
      var  c=AppCubit.get(context);
          return Center(
              child:SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        'Setting',
                        style: Theme.of(context).appBarTheme.titleTextStyle,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.indigo,
                                radius: 90.3,
                                child: Container(
                                  width:double.infinity,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:c.userdata.image!=null?c.userdata.image:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQagAOppyMeA7F5Dv98mR8mvCbPtCXO5bI_F-Q3aYg21g&s',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    width: 42,
                                    height: 42,
                                    imageBuilder:(context, imageProvider)=> CircleAvatar(
                                      backgroundImage: imageProvider,
                                    ),
                                  ),
                                ),

                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Icon(IconBroken.Edit,color: Theme.of(context).iconTheme.color,),
                                  TextButton(
                                    onPressed: () {
                                      navegatTo(context, UpdateProfile());
                                    },
                                    child:  Text('Edit Profile',style:  Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.lightBlue,fontSize: 20,fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('DarkMood',style:  Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.lightBlue,fontSize: 20,fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  Switch(value: c.isDark, onChanged:(val){
                                    c.changeMood();
                                  } ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(IconBroken.Logout,color: Theme.of(context).iconTheme.color,),
                                  TextButton(
                                    onPressed: () {
                                      c.currentIndex=0;
                                      navegatToAndFinsh(context, LoginScreen());
                                      c.signOut();
                                    },
                                    child:  Text('logOut',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.lightBlue,fontSize: 20,fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),



                    ],
                  ),
                ),
              )
          );
      },
    );
  }
}

