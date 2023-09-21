import 'package:flutter/material.dart';
import 'package:loginregister/controller/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'module/login/loginview.dart';
import 'state_utils.dart';

Map<String, WidgetBuilder> routes = {
  LoginView.routeName: (context) => const LoginView(),
};
void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final MyApp myApp =
      MyApp(initialRoute: (token != null) ? LoginView.routeName : '/');

  runApp(myApp);
}

//list
List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => LoginController()),
];

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({super.key, required this.initialRoute});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
          initialRoute: initialRoute,
          home: LoginView(),
          navigatorKey: Get.navigatorKey,
        ));
  }
}
