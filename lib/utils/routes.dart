import 'package:flutter/cupertino.dart';
import '../presentation/screens/auth_Screens/forget_password.dart';
import '../presentation/screens/auth_Screens/login_screen.dart';
import '../presentation/screens/auth_Screens/register_screen.dart';
import '../presentation/screens/home/cart_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/home/notification_screen.dart';
import '../presentation/screens/onboard_screen.dart';


class Routes {

  static Map<String, Widget Function(BuildContext)> route = {
    OnBoardScreen.routeName: (ctx) => const OnBoardScreen(),
    LoginScreen.routeName: (ctx) => const LoginScreen(),
    ForgetPassword.routeName: (ctx) => const ForgetPassword(),
    RegisterScreen.routeName: (ctx) => const RegisterScreen(),
    HomeScreen.routeName: (ctx) => const HomeScreen(),
    CartScreen.routeName: (ctx) => const CartScreen(),
    NotificationsScreen.routeName: (ctx) => const NotificationsScreen(),
  };
}
