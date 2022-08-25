import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/vestitems/basic_vest.dart';
import '../providers/basic_vests.dart' show BasicVests;

class ManageVestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<BasicVests>(context, listen: false)
          .fetchAndSetBasicVests(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<BasicVests>(
                  child: Center(
                    child: Text('Nincsen(ek) kiadható mellény(ek)'),
                  ),
                  builder: (ctx, basicVests, ch) => basicVests.itemCount == 0
                      ? ch
                      : ListView.builder(
                          itemBuilder: (context, index) =>
                              ChangeNotifierProvider.value(
                            value: basicVests.vests[index],
                            child: BasicVest(),
                          ),
                          itemCount: basicVests.itemCount,
                        ),
                ),
    );
  }
}
