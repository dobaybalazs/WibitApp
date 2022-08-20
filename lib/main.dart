//flutter related
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

//theme color
import './constants/main_color.dart' show MainColor;

//screens
import './screens/tabs_screen.dart';

//data
import './providers/basic_vests.dart';
import './providers/borrowed_vests.dart';
import 'providers/daily_customers.dart';

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
        ),
        ChangeNotifierProvider(
          create: (_) => DailyCustomers(),
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
          visualDensity: VisualDensity.adaptivePlatformDensity,
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
        home: SplashScreen(
          seconds: 4,
          navigateAfterSeconds: TabsScreen(),
          title: Text(
            'Loading app...',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          gradientBackground: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                MainColor.navyBlue.shade100,
                MainColor.navyBlue,
                Colors.blue,
              ]),
          loaderColor: Color.fromRGBO(255, 223, 0, 1.0),
          image: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
