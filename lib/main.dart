import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/ThemeMode.dart';
import 'pages/SplashScreen.dart';
//import 'package:flutter/services.dart';

main(List<String> args) {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //    // status BarColor: Colors.white,
    //     //statusBarIconBrightness: Brightness.dark,
    //     //systemNavigationBarIconBrightness: Brightness.dark
    // ));
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: notifier.darhTheme ? dark : light,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
