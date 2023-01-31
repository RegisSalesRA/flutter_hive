import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/completed_notes_chart_screen.dart';
import '../screens/completed_notes_screen.dart';
import '../screens/home_screen.dart';
import 'config.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'Flutter Sqflite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // PrimariColors from App css
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        // Progress Indicator Css
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: ColorsTheme.primaryColor),
        // Text Css
        textTheme: textThemeConfig(),
        // Input Css
        inputDecorationTheme: inputDecorationThemeConfig(),
        // Button css
        buttonTheme: buttonThemeDataConfig(),
        floatingActionButtonTheme: floatingActionButtonThemeData(),
        iconTheme: IconThemeData(color: ColorsTheme.primaryColor),
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: ColorsTheme.themeColor)
                .copyWith(secondary: ColorsTheme.primaryColor),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/complete': (context) => CompleteNoteScreen(),
        '/chart': (context) => CompleteNotesChartScreen(),
      },
    );
  }
}
