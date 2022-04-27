import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/layout/home_layout.dart';
import 'package:tech/screens/login_screen/cubit/login_cubit.dart';
import 'package:tech/screens/register_screen/register_screen.dart';
import 'package:tech/shared/cash_helper.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/styles/icon_broken.dart';

import 'cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  var formkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState){
            toast(text: state.error, state: FlutterToastState.error);
          }
          if (state is LoginSuccessState){
            CashHelper.saveData(key: 'uId', value: state.uId).then((value){
              navegatToAndFinsh(context, HomeLayout());
            });
          }
        },
        builder: (context, state) {
          var c = LoginCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://i.pinimg.com/564x/ce/3a/33/ce3a332c7c0822182efd62824c82fb94.jpg',
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      bottom: 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Welcome ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Text(
                            'Back! ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 1.42,
                    decoration:  BoxDecoration(
                      color:Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 20,),
                        child: Form(
                          key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              const SizedBox(height: 5,),
                               Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text('Login  ',style:Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),),
                              ),
                              const SizedBox(height: 30,),

                               Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text('UserName',style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),),
                              ),
                              const SizedBox(height: 10),

                              myFormField(
                                  controller: email,
                                  hint: 'Enter Your Email',
                                  type: TextInputType.emailAddress,
                                  prefix: IconBroken.Message,
                                  validate: (String val) {
                                    Pattern pattern =
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                        r"{0,253}[a-zA-Z0-9])?)*$";
                                    RegExp reg = new RegExp(pattern);
                                    if (!reg.hasMatch(val) || val == null)
                                      return 'Enter a valid email address';
                                  }),
                              const  SizedBox(height: 30,),
                               Padding(
                                padding:  EdgeInsets.only(left: 20),
                                child: Text('Password',style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),),
                              ),
                              const  SizedBox(height: 10),
                              myFormField(
                                  controller: pass,
                                  hint: 'Enter Your Password',
                                  type: TextInputType.visiblePassword,
                                  prefix: IconBroken.Password,
                                  isPassword: c.isPassword,
                                  suffix: c.suffix,
                                  suffixOnPressed: () {
                                    c.changeLoginEye();
                                  },
                                  validate: (String val) {
                                    if (val.length < 6) {
                                      return 'can\'t be less than 6';
                                    }
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text('Forget Password?',style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),),
                                      onPressed: (){},
                                    ),

                                  ],
                                ),
                              ),
                              ConditionalBuilder(
                                condition: state is ! LoginLoadingState,
                                builder:(context)=> defaultButton(text:'Login',function: (){
                                if(formkey.currentState.validate()){
                                  c.userLogin(email: email.text,pass: pass.text).then((value){
                                    AppCubit.get(context).getUserData(FirebaseAuth.instance.currentUser.uid);
                                  });
                                }
                                }),
                                fallback: (context) =>const Center(child: CircularProgressIndicator()),
                              ),
                       const  SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200],
                               ),
                              child: MaterialButton(
                                onPressed:(){
                                  navegatTo(context,RegisterScreen());
                                },
                                child: const Text(
                                  'Create Account',
                                  style:  TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                minWidth: double.infinity,
                              ),
                            ),
                          ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
