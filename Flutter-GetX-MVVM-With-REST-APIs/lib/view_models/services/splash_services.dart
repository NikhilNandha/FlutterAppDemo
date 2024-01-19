

import 'dart:async';

import 'package:get/get.dart';
import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/view_models/controller/user_preference/user_prefrence_view_model.dart';

class SplashServices {

  UserPreference userPreference = UserPreference();

  void isLogin(){

    Timer(const Duration(seconds: 3) , () => Get.toNamed(RouteName.homeView) );


  }
}