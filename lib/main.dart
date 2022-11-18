import 'package:contactapp/layout/home_layout.dart';
import 'package:contactapp/modules/setting_screen.dart';
import 'package:contactapp/shared/constants/dark_theme.dart';
import 'package:contactapp/shared/constants/light_theme.dart';
import 'package:contactapp/shared/cubit/bloc_observer.dart';
import 'package:contactapp/shared/cubit/cubit.dart';
import 'package:contactapp/shared/cubit/states.dart';
import 'package:contactapp/shared/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/about.dart';

// Flutter R2-UN Woman project by Rasha Mohammed Hafez Omran

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  navigatorKey:
  navigatorKey;
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..createDatabase()
        ..changeAppMode(
          fromShared: isDark,
        ),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            title: 'Contact App',
            home: HomeLayout(),

            ///Dark Theme
            darkTheme: darkTheme(context),

            // The Default Theme
            theme: lightTheme(context),

            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,

            initialRoute: '/',
            routes: {
              // When navigating to the "/second" route, build the SecondScreen widget.
              '/settings': (context) => SettingScreen(),
               '/about': (context) => AboutScreen(),
               '/home': (context) => HomeLayout(),

               
              
            },
          );
        },
      ),
    );
  }
}
