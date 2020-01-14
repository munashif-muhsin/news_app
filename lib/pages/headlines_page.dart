import 'package:flutter/material.dart';
import 'package:news_app/components/headline_widget.dart';
import 'package:news_app/modal/headline.dart';

class HeadlinesPage extends StatefulWidget {
  @override
  _HeadlinesPageState createState() => _HeadlinesPageState();
}

class _HeadlinesPageState extends State<HeadlinesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search for Topic',
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
        ),
        actions: <Widget>[
          Switch(
            onChanged: (_) {},
            value: false,
            activeColor: Colors.white,
            inactiveTrackColor: Colors.grey[800],
            inactiveThumbColor: Colors.white54,
          )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return _buildHeadlineItem(index);
        },
      ),
    );
  }

  Widget _buildHeadlineItem(int index) {
    return HeadlineWidget(
      Headline(
        author: 'News18.com',
        description:
            'Meghna Gulzar\'s Chhapaak had earned Rs 19.02 crore till Sunday. The film stars Deepika Padukone and Vikrant Massey in the lead roles.',
        imageUrl:
            'https://images.news18.com/ibnlive/uploads/2018/10/pinarayi-vijayan.jpg',
        publishedDate: DateTime.now(),
        title:
            "National Institute of Nutrition study finds link between lead exposure and Alzheimer’s - The New Indian Express",
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
