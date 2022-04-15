import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/screens/login_screen/login_screen.dart';
import 'package:tech/screens/settings_screen/setting_screen.dart';
import 'package:tech/shared/cash_helper.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/components/const.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';
import 'package:tech/shared/styles/icon_broken.dart';

class UpdateProfile extends StatelessWidget {
  TextEditingController name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var pass = TextEditingController();
  var address = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var c = AppCubit.get(context);
        name.text = c.userdata.name;
        phone.text = c.userdata.phone;
        email.text = c.userdata.email;
        address.text = c.userdata.address;
        pass.text = c.userdata.pass;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Edit Profile ',
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              color: Colors.black,
              iconSize: 30,
              icon: const Icon(IconBroken.Arrow___Left_Circle),
              onPressed: () {
                navegatBack(context, SettingScreen());
              },
            ),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: c.profileImage != null
                                  ? FileImage(c.profileImage)
                                  : NetworkImage(
                                      c.userdata.image,
                                    ),
                            ),
                          ),
                          IconButton(
                            icon: const CircleAvatar(
                              radius: 20.0,
                              child: Icon(
                                IconBroken.Camera,
                                size: 16.0,
                              ),
                            ),
                            onPressed: () {
                              c.getProfileImage().then((value) {
                                c.uploadeProfileImage();
                              });

                            },
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                  onTap: () {
                                    name.text = '';
                                  },
                                  nonFocseBorder: true,
                                  controller: name,
                                  hint: '${c.userdata.name}',
                                  type: TextInputType.name,
                                  prefix: IconBroken.Profile,
                                  validate: (String val) {
                                    if (val.isEmpty) {
                                      return 'Name can\'t  be Empty';
                                    }
                                  }),
                              myFormField(
                                  onTap: () {
                                    email.text = '';
                                  },
                                  nonFocseBorder: true,
                                  controller: email,
                                  hint: '${c.userdata.email}',
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
                                onTap: () {
                                  phone.text = '';
                                },
                                nonFocseBorder: true,
                                controller: phone,
                                hint: '${c.userdata.phone}',
                                maxleanth: 11,
                                type: TextInputType.phone,
                                prefix: IconBroken.Call,
                                validate: (String val) {
                                  if (val.length < 11) {
                                    return 'phone can\'t be less than 11';
                                  }
                                },
                              ),
                              myFormField(
                                onTap: () {
                                  address.text = '';
                                },
                                nonFocseBorder: true,
                                controller: address,
                                hint: '${c.userdata.address}',
                                type: TextInputType.name,
                                prefix: IconBroken.Location,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              ConditionalBuilder(
                                condition: state is! UpdateUserSucessState&&state is ! UploadProfileImageLoadingState,
                                builder: (context) => defaultButton(
                                    text: 'Update',
                                    function: () {
                                      if (formkey.currentState.validate()) {
                                          c.updateUser(
                                              phone: phone.text,
                                              address: address.text,
                                              email: email.text,
                                              name: name.text);

                                      }
                                    }),
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator()),
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
    );
  }
}
