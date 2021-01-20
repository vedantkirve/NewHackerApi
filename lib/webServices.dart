import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

//call url needed

class WebServices {
  Future<Response> _getStory(int storyId) {
    return http.get(UrlHelper.urlForStory(storyId));
  }

  Future<List<Response>> get getTopStories async {
    final http.Response response = await http.get(UrlHelper.urlForTopStory());
    if (response.statusCode == 200) {
      Iterable storyIds = jsonDecode(response.body);
      return Future.wait(storyIds.take(50).map((storyId) {
        return _getStory(storyId);
      }));
    } else {
      throw Exception("Unable to fetch data!");
    }
  }
}

class UrlHelper {
  static String urlForTopStory() {
    return "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty";
  }

  static String urlForStory(int storyId) {
    return "https://hacker-news.firebaseio.com/v0/item/${storyId}.json?print=pretty";
  }
}
