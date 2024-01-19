

import 'dart:ui';

import 'package:getx_mvvm/data/network/network_api_services.dart';
import 'package:getx_mvvm/models/home/user_list_model.dart';
import 'package:getx_mvvm/res/app_url/app_url.dart';

class HomeRepository {

  final _apiService  = NetworkApiServices() ;

  Future<List<UserListModel>> userListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.userListApi);

    // Assuming your API response is a list, you should map it to a list of UserListModel
    List<UserListModel> userList = List<UserListModel>.from(
      (response as List).map(
            (user) => UserListModel.fromJson(user),
      ),
    );

    return userList;
  }


}