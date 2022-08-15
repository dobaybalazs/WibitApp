import 'package:flutter/material.dart';

//theme color
import './constants/main_color.dart' show MainColor;

//screens
import './screens/tabs_screen.dart';

void main() {
  runApp(WibitApp());
}

class WibitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WibitVestM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MainColor.navyBlue,
          accentColor: Color.fromRGBO(255, 223, 0, 1.0),
        ),
        fontFamily: 'Raleway',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      routes: {
        '/': (_) => TabsScreen(),
      },
    );
  }
}
