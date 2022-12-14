import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './borrowed_vests_screen.dart';
import 'daily_customers_screen.dart';
import './manage_vests_screen.dart';
import '../providers/daily_customers.dart';
import '../providers/borrowed_vests.dart';
import '../providers/basic_vests.dart';

import '../widgets/sheets/chart_sheet.dart';
import '../widgets/sheets/add_vest_sheet.dart';

enum PopupOptions { Start, Stop, Delete }

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

  PopupMenuItem _buildPopupItem(
      String text, IconData icon, PopupOptions option) {
    return PopupMenuItem(
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(
            width: 10,
          ),
          Text(text),
        ],
      ),
      value: option,
    );
  }

  @override
  void initState() {
    super.initState();
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
            const Text('Mellények')
          ]),
          actions: <Widget>[
            FittedBox(
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _startAddingNewVest(context);
                },
              ),
            ),
            FittedBox(
              child: IconButton(
                icon: const Icon(Icons.bar_chart),
                onPressed: () {
                  _showStats(context);
                },
              ),
            ),
          ],
        ),
      ),
      Page(
        body: BorrowedVestsScreen(),
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                height: 32,
              ),
              const SizedBox(
                width: 9,
              ),
              const Text('Kölcsönzött mellények')
            ],
          ),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (value) {
                setState(
                  () {
                    final borrowedData =
                        Provider.of<BorrowedVests>(context, listen: false);
                    final basicData =
                        Provider.of<BasicVests>(context, listen: false);
                    if (value == PopupOptions.Start) {
                      borrowedData.startAll();
                    } else if (value == PopupOptions.Stop) {
                      borrowedData.stopAll();
                    } else if (value == PopupOptions.Delete) {
                      borrowedData.items.forEach((element) {
                        basicData.addNewLifejacket(element.size, element.id);
                      });
                      borrowedData.deleteAllVests();
                    }
                  },
                );
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                _buildPopupItem(
                    'Összes indítása', Icons.play_arrow, PopupOptions.Start),
                _buildPopupItem(
                    'Összes megállítása', Icons.stop, PopupOptions.Stop),
                _buildPopupItem(
                    'Összes törlése', Icons.delete, PopupOptions.Delete),
              ],
            ),
          ],
        ),
      ),
      Page(
        body: DailyCustomersScreen(),
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                height: 32,
              ),
              const SizedBox(
                width: 9,
              ),
              const Text('Mai vásárlók')
            ],
          ),
          actions: <Widget>[
            FittedBox(
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text('Törli az összes mai vásárlót?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Nem'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Provider.of<DailyCustomers>(context, listen: false)
                                .deleteAllCustomers();
                          },
                          child: Text('Igen'),
                        )
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete_forever),
              ),
            )
          ],
        ),
      )
    ];
  }

  void _showStats(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => GestureDetector(
        child: ChartSheet(),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  void _startAddingNewVest(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) => GestureDetector(
        child: AddVestSheet(),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
      ),
    );
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
