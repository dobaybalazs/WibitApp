//flutter related
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

//theme color
import './constants/main_color.dart' show MainColor;

//screens
import './screens/tabs_screen.dart';

//database
import './helpers/db_helper.dart';

//data
import './providers/basic_vests.dart';
import './providers/borrowed_vests.dart';
import 'providers/daily_customers.dart';

void main() {
  runApp(WibitApp());
}

class WibitApp extends StatefulWidget {
  @override
  State<WibitApp> createState() => _WibitAppState();
}

class _WibitAppState extends State<WibitApp> {
  var _basicVests = [];
  var _dailyCustomers = [];
  var _borrowedVests = [];

  void _initData() async {
    final basicDataList = await DBHelper.getData('basic_vests');
    _basicVests = basicDataList
        .map((e) => BasicLifejacket(id: e['id'], size: e['size']))
        .toList();
    final customerDataList = await DBHelper.getData('daily_customers');
    _dailyCustomers = customerDataList
        .map(
          (e) => DailyCustomer(
            arrivalTime: DateTime.parse(e['arrivalTime']),
            name: e['name'],
            number: e['number'],
            signature: e['signature'],
            expdate: DateTime.parse(e['expdate']),
          ),
        )
        .toList();
    final borrowedVestsData = await DBHelper.getData('borrowed_vests');
    _borrowedVests = borrowedVestsData
        .map(
          (e) => BorrowedLifeJacket(
            id: e['id'],
            name: e['name'],
            duration: Duration(seconds: e['duration']),
            arrivalTime: e['arrivalTime'],
            size: e['size'],
          ),
        )
        .toList();
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BasicVests(_basicVests),
        ),
        ChangeNotifierProvider(
          create: (_) => BorrowedVests(_borrowedVests),
        ),
        ChangeNotifierProvider(
          create: (_) => DailyCustomers(_dailyCustomers),
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
          loadingText: Text(
            'Loading app...',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          title: Text(
            'WibitApp',
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
