import 'dart:collection';

import 'package:goorlanews/model/article.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  save(String key, LinkedHashMap<String, Article> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  _linkedToHashMap(LinkedHashMap<String, dynamic> favLinked) {
    HashMap<String, List<Article>> newMap =
        HashMap.from(favLinked.map((key, value) {
      List<Article> values = List.from(value);
      return MapEntry(
          key.toString(),
          values.map((theValue) {
            return theValue.toString();
          }).toList());
    }));

    return newMap;
  }
}
