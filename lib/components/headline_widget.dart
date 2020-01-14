import 'package:flutter/material.dart';
import 'package:news_app/modal/headline.dart';

class HeadlineWidget extends StatelessWidget {

  final Headline story;

  HeadlineWidget(this.story): assert(story != null);


  @override
  Widget build(BuildContext context) {

    return  Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        constraints: BoxConstraints(minHeight: 100),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                  image: NetworkImage(story.imageUrl),
                  placeholder: AssetImage('assets/images/placeholder.png'),
                  fit: BoxFit.cover,
                  height: 80,
                  width: 80,
                ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Text(
                    story.title,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Text(
                  story.description,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                )
                ),
              ],
            )
          ],
        ),
      );
  }
}