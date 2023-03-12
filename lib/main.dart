import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:translate_1/main_navigation.dart';

import 'package:translate_1/main_di.dart';
import 'package:translate_1/store/app_store.dart';

void main() {
  setupDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _navigation = MainNavigation();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIt.allReady(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          const primaryColorSwatch = Colors.teal;

          return StoreProvider(
            store: getIt.get<AppStore>().store,
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: primaryColorSwatch,
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(color: Colors.white)),
                  ),
                ),
                appBarTheme: const AppBarTheme(
                  titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                drawerTheme: const DrawerThemeData(
                  backgroundColor: Colors.white,
                ),
                colorScheme:
                    ColorScheme.fromSwatch(primarySwatch: primaryColorSwatch)
                        .copyWith(
                  secondary: primaryColorSwatch.shade200,
                  // tertiary: Colors.lime.shade200,
                  // secondary: Color(0xff3A6B35),
                  // secondary: Color(0xcfe3856b),
                  // secondary: Color(0xcfe3856b),
                  tertiary: const Color(0xFFE2D1F9),
                ),
                textTheme: const TextTheme(
                    headlineSmall: TextStyle(color: primaryColorSwatch)),
                // tertiary: Color(0xa0edcbd2)),
              ),
              routes: _navigation.routes,
              initialRoute: MainNavigationRouteNames.home,
            ),
          );
        });
  }
}
