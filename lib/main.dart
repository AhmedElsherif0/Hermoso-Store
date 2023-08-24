import 'package:hermoso_store/presentation/screens/auth_Screens/login_screen.dart';
import 'package:hermoso_store/presentation/screens/home/home_screen.dart';
import 'package:hermoso_store/utils/constants.dart';
import 'package:hermoso_store/utils/routes.dart';
import 'package:hermoso_store/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'data/database/api_service/dio_service.dart';
import 'data/database/local_data/shared_preferences.dart';
import 'domain/cubit/authUser/auth_users_cubit.dart';
import 'domain/cubit/global_cubit/cart/cart_cubit.dart';
import 'domain/cubit/global_cubit/categories/categories_cubit.dart';
import 'domain/cubit/global_cubit/home/home_cubit.dart';
import 'domain/cubit/global_cubit/products/products_cubit.dart';
import 'domain/cubit/global_cubit/settings/settings_cubit.dart';
import 'presentation/screens/onboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioService.init();
  await SharedPref.init();

  bool isDarkTheme = SharedPref.getData(key: 'dark') ?? false;
  print('main dark Theme = ${isDarkTheme.toString()}');
  Widget widget = await const InitializeClass().initFunc();

  runApp(MyApp(isDark: isDarkTheme, widget: widget));
}

class MyApp extends StatefulWidget {
  final Widget widget;
  final bool isDark;

  const MyApp({Key? key, this.widget = const OnBoardScreen(), this.isDark = false})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _productsCubit = ProductsCubit();

  @override
  void dispose() {
    _productsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthUsersCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => CartCubit()..readCart()),
        BlocProvider(create: (context) => CategoriesCubit()),
        BlocProvider(
            create: (context) => SettingsCubit()
              ..getUserProfile()
              ..switchThemeMode(themeMode: widget.isDark)),
        BlocProvider(create: (context) => _productsCubit..getAllRemoteData()..getFavorites()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsStates>(
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                title: 'Flutter Demo',
                useInheritedMediaQuery: true,
                debugShowCheckedModeBanner: false,
                darkTheme: darkThemeMode(),
                theme: lightThemeMode(),
                themeMode: BlocProvider.of<SettingsCubit>(context).isDarkMode
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: widget.widget,
                routes: Routes.route(_productsCubit),
              );
            },
          );
        },
      ),
    );
  }
}

class InitializeClass {
  const InitializeClass();

  Future<Widget> initFunc() async {
    Widget widget = const OnBoardScreen();
    bool? boardScreen = await SharedPref.getData(key: 'BoardScreen');
    print('onboard main Screen ${boardScreen.toString()}');
    AppStrings.token = await SharedPref.getData(key: 'token');
    print('main token = ${AppStrings.token.toString()}');
    if (boardScreen != null) {
      AppStrings.token != null && AppStrings.token != ''
          ? widget = const HomeScreen()
          : widget = const LoginScreen();
    } else {
      widget = const OnBoardScreen();
    }
    return widget;
  }
}
