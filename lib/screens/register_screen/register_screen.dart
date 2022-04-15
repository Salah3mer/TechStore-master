import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/screens/login_screen/login_screen.dart';
import 'package:tech/screens/register_screen/cubit/register_cubit.dart';
import 'package:tech/screens/register_screen/cubit/register_states.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/styles/icon_broken.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=> RegsiterCubit(),
      child: BlocConsumer<RegsiterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            toast(text: 'SignUp Successfully', state: FlutterToastState.success);
            navegatToAndFinsh(context, LoginScreen());
          } else if (state is RegisterErrorState) {
            toast(text: state.error, state: FlutterToastState.error);
          }
        },
        builder: (context, state) {
          var c = RegsiterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: AlignmentDirectional.bottomStart,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/register.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Register Now ',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('To get Our Hot Products',
                                style: TextStyle(fontSize: 20)),
                          ],
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                myFormField(
                                    controller: name,
                                    label: 'Name',
                                    type: TextInputType.name,
                                    prefix: IconBroken.Profile,
                                    validate: (String val) {
                                      if (val.isEmpty) {
                                        return 'Name can\'t  be Empty';
                                      }
                                    }),
                                myFormField(
                                    controller: email,
                                    label: 'Email',
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
                                myFormField(
                                    controller: pass,
                                    label: 'Password',
                                    type: TextInputType.visiblePassword,
                                    prefix: IconBroken.Password,
                                    isPassword: c.isPassword,
                                    suffix: c.suffix,
                                    suffixOnPressed: () {
                                      c.changeEye();
                                    },
                                    validate: (String val) {
                                      if (val.length < 6) {
                                        return 'can\'t be less than 6';
                                      }
                                    }),
                                myFormField(
                                    controller: phone,
                                    label: 'Phone',
                                    maxleanth: 11,
                                    type: TextInputType.phone,
                                    prefix: IconBroken.Call,
                                    validate: (String val) {
                                      if (val.length < 11) {
                                        return 'phone can\'t be less than 11';
                                      }
                                    },
                                    onSubmit: (String val){
                                      if (formKey.currentState.validate()) {
                                        c.userInfo(
                                          name: name.text,
                                          email: email.text,
                                          pass: pass.text,
                                          phone: phone.text,
                                        );
                                      }
                                    }
                                    ),

                                const SizedBox(
                                  height: 5,
                                ),
                                ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  builder: (context) => defaultButton(
                                      text: 'SignUp',
                                      function: () {
                                        if (formKey.currentState.validate()) {
                                          c.userInfo(
                                            name: name.text,
                                            email: email.text,
                                            pass: pass.text,
                                            phone: phone.text,
                                          );

                                        }
                                      }),
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Already Have An Account ?'),
                                    TextButton(
                                        onPressed: () {
                                          navegatToAndFinsh(context, LoginScreen());
                                        },
                                        child: const Text('Login Now',
                                            style:
                                                TextStyle(color: Colors.blue)))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
