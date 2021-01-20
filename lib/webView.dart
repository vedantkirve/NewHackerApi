import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatefulWidget {
  final String newsUrl;
  ArticleWebView({@required this.newsUrl});
  @override
  _ArticleWebViewState createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FLutter News",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: WebView(
          initialUrl: widget.newsUrl,
        ),
      ),
    );
  }
}
