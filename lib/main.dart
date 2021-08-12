import 'package:firstdesign/cubit/login_cubit/login_cubit.dart';
import 'package:firstdesign/cubit/register_cubit/register_cubit.dart';
import 'package:firstdesign/data/local_data/shared_preferences.dart';
import 'package:firstdesign/data/service/dio_service.dart';
import 'package:firstdesign/ui/screens/auth_Screens/forget_password.dart';
import 'package:firstdesign/ui/screens/auth_Screens/login_screen.dart';
import 'package:firstdesign/ui/screens/auth_Screens/register_screen.dart';
import 'package:firstdesign/ui/screens/home/home_page.dart';
import 'package:firstdesign/ui/screens/onboard_screen.dart';
import 'package:firstdesign/utils/bloc_observer.dart';
import 'package:firstdesign/utils/constants.dart';
import 'package:firstdesign/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home/home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  await DioService.init();
  await SharedPref.Init();

  Widget widget = OnBoardScreen();
  bool? boardScreen = await SharedPref.getData(key: 'BoardScreen');

   token = await SharedPref.getData(key: 'token');

  if (boardScreen != null) if (token != null)
    widget = HomeScreen();
  else
    widget = LoginScreen();
  else
    widget = OnBoardScreen();

  runApp(MyApp(widget: widget));
}

Future<Widget> authToken(Widget widget, token, boardScreen) async {
  return widget;
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp({this.widget = const OnBoardScreen()});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => HomeCubit()..getData()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightThemeMode(),
        home: widget,
        routes: {
          OnBoardScreen.routeName: (ctx) => OnBoardScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          ForgetPassword.routeName: (ctx) => ForgetPassword(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
