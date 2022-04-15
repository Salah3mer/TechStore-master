import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/models/user_model.dart';
import 'package:tech/screens/register_screen/cubit/register_states.dart';
import 'package:tech/shared/styles/icon_broken.dart';

class RegsiterCubit extends Cubit<RegisterStates> {
  RegsiterCubit() :super(RegisterInitState());
  static RegsiterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = IconBroken.Hide;

  void changeEye() {
    isPassword = !isPassword;
    suffix = isPassword ? IconBroken.Hide : IconBroken.Show;
    emit(ChangeEyeState());
  }

  void userInfo({
    @required name,
    @required email,
    @required pass,
    @required phone,
    image,
    address,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: pass).
    then((value) {
      createUser(uId:value.user.uid, name: name, email: email, phone: phone,pass: pass,image:image,address: address);
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  void createUser({
    @required uId,
    @required name,
    @required email,
    @required phone,
    @required pass,
    String image,
    String address,
  }) {
    UserModel model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      pass: pass,
      image: image,
      address: address,
    );

    FirebaseFirestore.instance.collection('users').doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(CreateUserSuccessState());
    }).catchError((error){
      emit(CreateUserErrorState(error.toString()));
    });
  }

}