import 'package:flutter/material.dart';

import './borrowed_vests_screen.dart';
import './daily_costumers_screen.dart';
import './manage_vests_screen.dart';

class Page {
  final Widget body;
  final Widget appBar;

  Page({@required this.body, @required this.appBar});
}

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Page> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      Page(
        body: ManageVestsScreen(),
        appBar: AppBar(
          title: Row(children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              height: 32,
            ),
            const SizedBox(
              width: 9,
            ),
            const Text('Mellények kezelése')
          ]),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.bar_chart),
              onPressed: () {},
            ),
          ],
        ),
      ),
      Page(
        body: BorrowedVestsScreen(),
        appBar: AppBar(
          title: const Text('Kölcsönzött mellények'),
        ),
      ),
      Page(
        body: DailyCostumersScreen(),
        appBar: AppBar(
          title: const Text('Mai vásárlók'),
        ),
      )
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pages[_selectedPageIndex].appBar,
      body: _pages[_selectedPageIndex].body,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.backpack_outlined), label: 'Part'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time_outlined), label: 'Pálya'),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'Vásárlók'),
        ],
      ),
    );
  }
}