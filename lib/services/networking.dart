import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper{
  String url;

  NetworkHelper({ required this.url });

  Future getData() async {
    var uri = Uri.parse(url);
    Response response = await get(uri);
    String data = response.body;
    var decodedData = jsonDecode(data);
    return decodedData;
  }
}