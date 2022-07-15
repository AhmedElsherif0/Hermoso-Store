import 'package:flutter/cupertino.dart';
import 'package:hermoso_store/model/products/product_model.dart';
import 'package:hermoso_store/ui/screens/auth_Screens/forget_password.dart';
import 'package:hermoso_store/ui/screens/auth_Screens/login_screen.dart';
import 'package:hermoso_store/ui/screens/auth_Screens/register_screen.dart';
import 'package:hermoso_store/ui/screens/home/card_screen.dart';
import 'package:hermoso_store/ui/screens/home/home_page.dart';
import 'package:hermoso_store/ui/screens/home/notification_screen.dart';
import 'package:hermoso_store/ui/screens/onboard_screen.dart';

class Routes {
  final productModel  = const RouteSettings().arguments as ProductModel;

  static Map<String, Widget Function(BuildContext)> route = {
    OnBoardScreen.routeName: (ctx) => const OnBoardScreen(),
    LoginScreen.routeName: (ctx) => const LoginScreen(),
    ForgetPassword.routeName: (ctx) => const ForgetPassword(),
    RegisterScreen.routeName: (ctx) => const RegisterScreen(),
    HomeScreen.routeName: (ctx) => const HomeScreen(),
    CardScreen.routeName: (ctx) => const CardScreen(),
    NotificationsScreen.routeName: (ctx) => const NotificationsScreen(),
  };
}
