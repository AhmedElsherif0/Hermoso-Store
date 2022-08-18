import 'package:hermoso_store/cubit/authUser/auth_users_cubit.dart';
import 'package:hermoso_store/cubit/global_cubit/cart/cart_cubit.dart';
import 'package:hermoso_store/data/local_data/shared_preferences.dart';
import 'package:hermoso_store/data/service/dio_service.dart';
import 'package:hermoso_store/presentation/screens/auth_Screens/login_screen.dart';
import 'package:hermoso_store/presentation/screens/home/home_screen.dart';
import 'package:hermoso_store/utils/constants.dart';
import 'package:hermoso_store/utils/routes.dart';
import 'package:hermoso_store/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'cubit/global_cubit/categories/categories_cubit.dart';
import 'cubit/global_cubit/home/home_cubit.dart';
import 'cubit/global_cubit/products/products_cubit.dart';
import 'cubit/global_cubit/settings/settings_cubit.dart';
import 'presentation/screens/onboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioService.init();
  await SharedPref.init();


  Widget widget = const OnBoardScreen();
  bool? boardScreen = SharedPref.getData(key: 'BoardScreen');
  print('onboard main Screen ${boardScreen.toString()}');
  token = await SharedPref.getData(key: 'token');
  bool isDarkTheme = SharedPref.getData(key: 'dark') ?? false;
  print('main token = ${token.toString()}');
  print('main dark Theme = ${isDarkTheme.toString()}');

  if (boardScreen != null) {
    token != null && token != ''
        ? widget = const HomeScreen()
        : widget = const LoginScreen();
  } else {
    widget = const OnBoardScreen();
  }

  runApp(MyApp(isDark: isDarkTheme, widget: widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  final bool isDark;

  const MyApp(
      {Key? key, this.widget = const OnBoardScreen(), this.isDark = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthUsersCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => CategoriesCubit()),
        BlocProvider(
            create: (context) => SettingsCubit()
              ..getUserProfile()
              ..switchThemeMode(themeMode: isDark)),
        BlocProvider(create: (context) => ProductsCubit()..getAllRemoteData()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsStates>(
        builder: (context, state) {
          return Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              title: 'Flutter Demo',
              useInheritedMediaQuery: true,
              debugShowCheckedModeBanner: false,
              darkTheme: darkThemeMode(),
              theme: lightThemeMode(),
              themeMode: BlocProvider.of<SettingsCubit>(context).isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: widget,
              routes: Routes.route,
            );
          });
        },
      ),
    );
  }
}
