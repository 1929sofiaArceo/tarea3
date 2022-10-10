import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class MyProvider with ChangeNotifier {

  Map _result = {};
  bool _isLoading = false;

  Map get result => _result;
  bool get isLoading => _isLoading;

  void setResult(Map queryResult) {
    _result = queryResult;
    notifyListeners();
  }

  Future<void> search(params) async {
    Uri url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q='+params);
    _isLoading = true;
    notifyListeners();
    sleep(Duration(seconds:3));
    var response = await http.get(url);
     _isLoading = false;
    var parsed = json.decode(response.body);
    setResult(parsed);
  }

}