import 'package:flutter/material.dart';
import 'package:news_app/headlines_page.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            HeadlinesPage(),
            Container(
              color: Colors.yellow,
            )
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: TabBar(
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.black38,
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.accessibility_new,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.account_balance,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
