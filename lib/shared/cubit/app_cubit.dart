import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech/models/banner_model.dart';
import 'package:tech/models/category_model.dart';
import 'package:tech/models/product_model.dart';
import 'package:tech/models/user_model.dart';
import 'package:tech/screens/category_screen/category_screen.dart';
import 'package:tech/screens/favorite_screen/favorite_screen.dart';
import 'package:tech/screens/home_screen/home_screen.dart';
import 'package:tech/screens/settings_screen/setting_screen.dart';
import 'package:tech/shared/components/const.dart';
import 'package:tech/shared/styles/icon_broken.dart';
import 'app_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel userdata;

  void getUserData(String uId) {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userdata = UserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((err) {
      emit(GetUserErrorState());
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(UserSingOutSuccessState());
  }

  int currentIndex = 0;
  List<IconData> listOfIcons = [
    IconBroken.Home,
    IconBroken.Heart,
    IconBroken.Category,
    IconBroken.Setting,
  ];

  List<Widget> screens = [
    HomeScreen(),
    FavoriteScreen(),
    CategoryScreen(),
    SettingScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  List<CategoryModel> category = [];

  void getCategory({
    String token,
  }) {
    emit(GetCategoryLoadingState());
    FirebaseFirestore.instance.collection('category').get().then((value) {
      value.docs.forEach((element) {
        category.add(CategoryModel.fromJson(element.data()));
      });
      emit(GetCategorySuccessState());
    }).catchError((error) {
      emit(GetCategoryErrorState());
      print(error.toString());
    });
  }

  List<ProductModel> product = [];
  List<ProductModel> favProduct = [];
  List<bool> fav = [];

  getProduct({String token}) {
    emit(GetProductLoadingState());
    FirebaseFirestore.instance.collection('product').get().then((value) {
      value.docs.forEach((element) {
        product.add(ProductModel.fromJson(element.data()));
        if (element['fav'].toString().contains(userdata.uId)) {
          fav.add(true);
        } else {
          fav.add(false);
        }
      });
      emit(GetProductSuccessState());
    }).catchError((error) {
      emit(GetProductErrorState());
      print(error.toString());
    });
  }

  List<BannerModel> banner = [];

  void getBanner({
    String token,
  }) {
    emit(GetBannerLoadingState());
    FirebaseFirestore.instance.collection('banners').get().then((value) {
      value.docs.forEach((element) {
        banner.add(BannerModel.fromJson(element.data()));
      });
      emit(GetBannerSuccessState());
    }).catchError((error) {
      emit(GetBannerErrorState());
      print(error.toString());
    });
  }

  List<ProductModel> catproduct = [];
  int catIndex;
  int currentProductIndex;

  bool isPassword = true;
  IconData suffix = IconBroken.Hide;

  void changeEye() {
    isPassword = !isPassword;
    suffix = isPassword ? IconBroken.Hide : IconBroken.Show;
    emit(ChangeEyeState());
  }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickProfileImageSuccessState());
    } else
      print('noImageSelected');
  }

  String profileImageUrl = '';

  Future<void> uploadeProfileImage() async {
    profileImageUrl = '';
    emit(UploadProfileImageLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        profileImageUrl = value;
        emit(UploadProfileImageSuccessState());
      }).catchError((err) {
        emit(UploadProfileImageErrorState());
        print(err.toString());
      });
    }).catchError((err) {
      emit(UploadProfileImageErrorState());
      print(err.toString());
    });
  }

  void updateUser({
    @required String phone,
    @required String address,
    @required String email,
    @required String name,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      pass: userdata.pass,
      address: address,
      uId: userdata.uId,
      image: profileImageUrl != '' ? profileImageUrl : userdata.image,
      phone: phone,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userdata.uId)
        .update(model.toMap())
        .then((value) {
      getUserData(uId);
      emit(UpdateUserSucessState());
    }).catchError((err) {
      print(err);
      emit(UpdateUserErrorState());
    });
  }

  void changeFav(productId, index) {
    if (fav[index] == false) {
      fav[index] = !fav[index];
      addToFav(productId, index);
    } else {
      fav[index] = !fav[index];
      removeFromFav(productId, index);
    }
    emit(ChangeFavState());
  }

  void addToFav(productId, index) {
    FirebaseFirestore.instance.collection('product').doc(productId).update({
      'fav': FieldValue.arrayUnion([userdata.uId]),
    }).then((value) {
      emit(AddToFavouriteSucessState());
    }).catchError((err) {
      emit(AddToFavouriteErrorState());
    });
  }

  void removeFromFav(productId, index) {
    FirebaseFirestore.instance.collection('product').doc(productId).update({
      'fav': FieldValue.arrayRemove([userdata.uId]),
    }).then((value) {
      emit(RemoveFavouriteSucessState());
    }).catchError((err) {
      emit(RemoveFavouriteErrorState());
    });
  }

  List<ProductModel> cartItem = [];
  var SubPrice = 0;
  var Price = 0;

  subPrice(ProductModel p) {
    return SubPrice = p.quantity * p.price;
  }

  totalPrice(p) {
    Price = 0;
    for (var product in p) {
      Price += product.quantity * product.price;
    }
    return Price;
  }

  void add(ProductModel p) {
    p.quantity++;
    emit(Plus());
  }

  void subtract(ProductModel p) {
    if (p.quantity < 2) {
      RemoveFromCart(p);
    } else {
      p.quantity--;
    }
    emit(Subtract());
  }

  void addToCart(ProductModel p) {
    p.quantity = 1;
    bool inCart = cartItem.contains(p);
    if (inCart) {
      print('added before');
    } else {
      cartItem.add(p);
    }
    emit(AddToCartSucessState());
  }

  void RemoveFromCart(ProductModel p) {
    cartItem.remove(p);
    emit(RemoveFromCartSucessState());
  }
  void order(String totalPrice, String address, List<ProductModel> product) {
    FirebaseFirestore.instance.collection('order').doc(userdata.uId).set({
      'totalPrice': totalPrice,
      'address': address,
    });
    for (var p in product)
      FirebaseFirestore.instance
          .collection('order')
          .doc(userdata.uId)
          .collection('OrderDetails')
          .doc()
          .set({
        'id': p.id,
        'name': p.name,
        'image': p.urlImage,
        'price': p.price,
        'quantity': p.quantity,
      }).then((value) {
        emit(OrderSucessState());
      }).catchError((err){
        emit(OrderErrorState());
      });
  }
}
