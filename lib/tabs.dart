import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/pages/headlines_page.dart';
import 'package:news_app/pages/iot_page.dart';

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
            IOTPage(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              spreadRadius: 1.5,
              blurRadius: 8,
              offset: Offset(0, -7),
            ),
          ], color: Colors.white),
          child: SafeArea(
            child: TabBar(
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.black38,
              labelColor: Colors.black,
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.listUl,
                    size: 20,
                  ),
                ),
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.chartBar,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
