import 'package:flutter/material.dart';
import 'package:news_app/blocs/headline_bloc.dart';
import 'package:news_app/components/headline_widget.dart';
import 'package:news_app/modal/headline.dart';
import 'package:news_app/services/news_service.dart';

class HeadlinesPage extends StatefulWidget {
  @override
  _HeadlinesPageState createState() => _HeadlinesPageState();
}

class _HeadlinesPageState extends State<HeadlinesPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _editingController = TextEditingController();
  String _searchText;
  bool _showCancel = false;
  bool _shouldAutoRefresh= false;
  HeadlinesBloc _headlinesBloc = HeadlinesBloc();

  @override
  void initState() {
    super.initState();
    _refreshFeed(null);
  }

  void _refreshFeed(String text) {
    _headlinesBloc.refreshFeed(text);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            controller: _editingController,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(FocusNode());
              if (_editingController.text.isNotEmpty) {
                _refreshFeed(_editingController.text);
                setState(() {
                  _showCancel = true;
                });
              }
            },
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search for Topic',
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
        ),
        actions: <Widget>[
          AnimatedOpacity(
            opacity: _showCancel ? 1 : 0,
            duration: Duration(milliseconds: 200),
            child: IconButton(icon: Icon(Icons.cancel), onPressed: () {
              _editingController.clear();
              _refreshFeed(null);
              setState(() {
                _showCancel = false;
              });
            },),
          ),
          Switch(
            onChanged: (bool value) {
              setState(() {
                _shouldAutoRefresh = value;
              });
            },
            value: _shouldAutoRefresh,
            activeColor: Colors.white,
            inactiveTrackColor: Colors.grey[800],
            inactiveThumbColor: Colors.white54,
          )
        ],
      ),
      body: StreamBuilder<List<Headline>>(
        stream: _headlinesBloc.headlineStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Headline> headlines;
          if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            headlines = snapshot.data;
            if (headlines.length < 1) {
              return Center(
                child: Text('No results found. Try another query'),
              );
            }
            return ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: headlines.length > 10 ? 10 : headlines.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildHeadlineItem(headlines[index]);
                },
              );
          }
          return Center(
            child: Text('Something went wrong. Please try again later'),
          );
        },
      ),
    );
  }

  Widget _buildHeadlineItem(Headline item) {
    return HeadlineWidget(
      Headline(
        author: item.author,
        description: item.description,
        imageUrl: item.imageUrl,
        publishedDate: item.publishedDate,
        title: item.title,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
