import "package:flutter/material.dart";

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
  'TRY'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const List<Color> cryptoListColors = [
  Colors.red,
  Colors.blue,
  Colors.orangeAccent,
];

class CoinData {
  final dynamic coinData;
  late int price;

  CoinData({ required this.coinData }){
    if(coinData != null){
      double price = coinData["rate"];
      this.price = price.toInt();
    } else {
      price = -1;
    }
  }
}
