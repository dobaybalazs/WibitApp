//flutter related
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//theme color
import './constants/main_color.dart' show MainColor;

//screens
import './screens/tabs_screen.dart';

//data
import './providers/basic_vests.dart';
import './providers/borrowed_vests.dart';

void main() {
  runApp(WibitApp());
}

class WibitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BasicVests(),
        ),
        ChangeNotifierProvider(
          create: (_) => BorrowedVests(),
        )
      ],
      child: MaterialApp(
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
          textTheme: TextTheme(
            titleMedium: TextStyle(
              fontSize: 18,
            ),
            titleSmall: TextStyle(
              fontSize: 16,
              color: Color(0xff262b2f),
            ),
          ),
        ),
        routes: {
          '/': (_) => TabsScreen(),
        },
      ),
    );
  }
}
