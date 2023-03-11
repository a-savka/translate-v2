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

          return StoreProvider(
            store: getIt.get<AppStore>().store,
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              routes: _navigation.routes,
              initialRoute: MainNavigationRouteNames.home,
            ),
          );
        });
  }
}
