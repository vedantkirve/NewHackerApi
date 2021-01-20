import 'dart:convert';
import 'package:flutter/services.dart';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_new_app_hacker_news/story.dart';
import 'package:flutter_new_app_hacker_news/webServices.dart';
import 'package:flutter_new_app_hacker_news/webView.dart';

class TopArticles extends StatefulWidget {
  @override
  _TopArticlesState createState() => _TopArticlesState();
}

class _TopArticlesState extends State<TopArticles> {
  //Widget NewList(){return }

  List<Story> _stories = List<Story>();

  @override
  void initState() {
    super.initState();
    topStories();
  }

  // Widget newsList() {
  //   return _stories != null
  //       ? Container(
  //           child: Column(
  //             children: <Widget>[
  //               ListView.builder(
  //                   itemCount: null,
  //                   itemBuilder: (context, index) {
  //                     return NewsTile(
  //                         title: _stories[index].title,
  //                         by: _stories[index].by,
  //                         commentsCount: _stories[index].commentIds.length);
  //                   })
  //             ],
  //           ),
  //         )
  //       : Container(
  //           alignment: Alignment.center,
  //           child: CircularProgressIndicator(),
  //         );
  // }

  void topStories() async {
    final responses = await WebServices().getTopStories;
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();

    setState(() {
      _stories = stories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "News App",
            style: TextStyle(fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: Container(
            child: ListView.builder(
                itemCount: _stories.length,
                itemBuilder: (context, index) {
                  return Wrap(children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        print("pressed the tile");
                        String url = _stories[index].url;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ArticleWebView(newsUrl: url)));
                      },
                      child: Container(
                        //height: 170,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            color: Colors.white60),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            //by
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "posterd by " + _stories[index].by,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.blue[200]),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //tile
                            Text(
                              _stories[index].title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //Comments no
                            GestureDetector(
                              onTap: () {
                                print("pressed cOMMENTS");
                              },
                              child: Row(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Container(
                                      child: Icon(Icons.comment),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 3.0),
                                      child: Text(_stories[index]
                                          .commentIds
                                          .length
                                          .toString()),
                                    ),
                                    Text("Comments"),
                                  ]),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      12.0,
                                      0,
                                      0,
                                      0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(new ClipboardData(
                                            text: _stories[index].url));
                                        print("pressed share");
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Icon(Icons.share),
                                          ),
                                          Text("Share")
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]);
                })));
  }
}

//Designing of how the news title should Look
// class NewsTile extends StatelessWidget {
//   final String title, by;
//   final int commentsCount;

//   NewsTile(
//       {@required this.title, @required this.by, @required this.commentsCount});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150,
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(color: Colors.white),
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 5,
//           ),
//           //by
//           Text(
//             by,
//             style: TextStyle(fontSize: 13, color: Colors.blue[200]),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           //tile
//           Text(
//             title,
//             style: TextStyle(fontSize: 20, color: Colors.black),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           //Comments no
//           GestureDetector(
//             onTap: () {
//               print("pressed");
//             },
//             child: Row(
//               children: <Widget>[
//                 Container(
//                   child: Icon(Icons.comment),
//                 ),
//                 Text(commentsCount.toString()),
//                 Text("Comments"),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
