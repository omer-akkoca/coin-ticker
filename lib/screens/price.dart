import "package:bitcoin_ticker/components/crypto_item.dart";
import "package:bitcoin_ticker/services/coin_data.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/foundation.dart";

class Price extends StatefulWidget {
  const Price({super.key});

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {
  String selectedCurrency = "AUD";

  DropdownButton<String> getDropDownItemsForAndroid(){
    List<DropdownMenuItem<String>> items = [];

    for(String currency in currenciesList){
      DropdownMenuItem<String> item = DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );

      items.add(item);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: items,
      onChanged: (e) {
        calculateCost(e!);
      },
    );
  }

  CupertinoPicker getDropDownItemsForIOS(){
    List<Widget> items = [];

    for(String currency in currenciesList){
      Widget item = Center(child: Text(currency));
      items.add(item);
    }

    return CupertinoPicker(itemExtent: 50, onSelectedItemChanged: (e){
      calculateCost(currenciesList[e]);
    }, children: items,);
  }

  Widget getDropDown(){
    if(defaultTargetPlatform == TargetPlatform.android){
      return getDropDownItemsForAndroid();
    } else if(defaultTargetPlatform == TargetPlatform.iOS){
      return getDropDownItemsForIOS();
    }
    return const Text("Unvalid Device");
  }

  void calculateCost(String currency) async {
    setState(() {
      selectedCurrency = currency;
    });
  }

  List<Widget> getListCryptoItem(){
    List<Widget> items = [];
    for(var i = 0; i < cryptoList.length; i++ ){
      Widget item = CryptoItem(crypto: cryptoList[i], currency: selectedCurrency, color: cryptoListColors[i],);
      items.add(item);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Coin Ticker",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: getListCryptoItem(),
              ),
            ),
          ),
          Container(
            height: 225,
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(
                  6,
                  1.0,
                ),
                blurRadius: 5,
                spreadRadius: 1,
              )
            ]),
            child: Center(
              child: getDropDown()
            ),
          ),
        ],
      ),
    );
  }
}