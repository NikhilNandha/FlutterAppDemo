import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/data/response/status.dart';
import 'package:getx_mvvm/res/components/general_exception.dart';
import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/view_models/controller/user_preference/user_prefrence_view_model.dart';

import '../../res/components/internet_exceptions_widget.dart';
import '../../view_models/controller/home/home_view_models.dart';
import 'details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final homeController = Get.put(HomeController());

  UserPreference userPreference = UserPreference();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.userListApi();

  }
  void _navigateToDetails(BuildContext context, String title, String text) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(title: title, text: text),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.indigo, // Change the background color of the AppBar
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white, // Change the icon color
            ),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white, // Change the icon color
            ),
            onPressed: () {
              // Handle search icon tap
            },
          ),
        ],
      ),
      body: Obx((){
        switch(homeController.rxRequestStatus.value){
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            if(homeController.error.value =='No internet'){
              return InterNetExceptionWidget(onPress: () {
                homeController.refreshApi();
              },);
            }else {
              return GeneralExceptionWidget(onPress: (){
                homeController.refreshApi();
              });
            }
          case Status.COMPLETED:
            return ListView.builder(
              itemCount: homeController.userList.value.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color:   Colors.blueAccent,//index % 2 == 1 ? Colors.blueAccent : Colors.teal, // Change the background color of the card
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    title: Text(
                      homeController.userList.value[index].name.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white, // Change the text color
                      ),
                    ),
                    subtitle: Text(
                      homeController.userList.value[index].tag.toString(),
                      style: const TextStyle(
                        color: Colors.white70, // Change the text color
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white, // Change the background color
                      child: Text(
                        homeController.userList.value[index].name.toString()[0],
                        style: const TextStyle(
                          color: Colors.teal, // Change the text color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      _navigateToDetails(context, homeController.userList.value[index].name.toString(), homeController.userList.value[index].tag.toString());
                    },
                  ),
                );
              },
            );
        }
      }),
    );
  }
}
