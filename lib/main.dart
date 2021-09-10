import 'package:hermoso_store/cubit/login_cubit/login_cubit.dart';
import 'package:hermoso_store/cubit/register_cubit/register_cubit.dart';
import 'package:hermoso_store/data/local_data/shared_preferences.dart';
import 'package:hermoso_store/data/service/dio_service.dart';
import 'package:hermoso_store/ui/screens/auth_Screens/forget_password.dart';
import 'package:hermoso_store/ui/screens/auth_Screens/login_screen.dart';
import 'package:hermoso_store/ui/screens/auth_Screens/register_screen.dart';
import 'package:hermoso_store/ui/screens/home/home_page.dart';
import 'package:hermoso_store/ui/screens/onboard_screen.dart';
import 'package:hermoso_store/utils/bloc_observer.dart';
import 'package:hermoso_store/utils/constants.dart';
import 'package:hermoso_store/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home/home_cubit.dart';
import 'cubit/home/products/products_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  await DioService.init();
  await SharedPref.init();

  Widget widget = const OnBoardScreen();
  bool? boardScreen = await SharedPref.getData(key: 'BoardScreen');

  token = await SharedPref.getData(key: 'token');

  if (boardScreen != null) {
    if (token != null) {
      widget = const HomeScreen();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardScreen();
  }

  runApp(MyApp(widget: widget));
}

Future<Widget> authToken(Widget widget, token, boardScreen) async {
  return widget;
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp({Key? key, this.widget = const OnBoardScreen()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ProductsCubit()..getData()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightThemeMode(),
        home: widget,
        routes: {
          OnBoardScreen.routeName: (ctx) => const OnBoardScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          ForgetPassword.routeName: (ctx) => const ForgetPassword(),
          RegisterScreen.routeName: (ctx) => const RegisterScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
        },
      ),
    );
  }
}
