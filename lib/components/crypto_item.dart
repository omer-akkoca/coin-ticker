import "package:bitcoin_ticker/constants/constants.dart";
import "package:bitcoin_ticker/services/coin_data.dart";
import "package:bitcoin_ticker/services/networking.dart";
import "package:flutter/material.dart";

class CryptoItem extends StatefulWidget {

  final String crypto;
  final String currency;
  final Color color;

  const CryptoItem({super.key, required this.crypto, required this.currency, required this.color});

  @override
  State<CryptoItem> createState() => _CryptoItem();
}

class _CryptoItem extends State<CryptoItem> {

  late String currency;
  int price = 0;

  @override
  void didUpdateWidget(covariant CryptoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      currency = widget.currency;
    });
    calculateCost();
  }

  void calculateCost() async {
    debugPrint(currency);
    String url = "$baseUrl/exchangerate/${widget.crypto}/$currency?apikey=$apiKey";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    debugPrint("DATA: ${data.toString()}");
    if(data != null){
      CoinData coinPrice = CoinData(coinData: data);
      setState(() {
        price = coinPrice.price;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x55000000),
            offset: Offset(1.0, 2.0),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          )
        ],
      ),
      child: Center(
        child: Text("1 ${widget.crypto} = $price ${widget.currency}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
