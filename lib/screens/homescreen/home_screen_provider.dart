import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../model/currency.dart';

class HomeScreenProvider extends ChangeNotifier {
  String btcUsdtPrice = "0.0";
  List<CurrencyData> currencyList = [];

  final channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/btcusdt@trade');

  final image = [
    Image.asset(
      'assets/images/bitcoin.jpeg',
      width: 30,
      height: 30,
    ),
    Image.asset(
      'assets/images/busd.png',
      width: 30,
      height: 30,
    ),
    Image.asset(
      'assets/images/etherium.png',
      width: 30,
      height: 30,
    ),
    Image.asset(
      'assets/images/litecoin.png',
      width: 30,
      height: 30,
    ),
    Image.asset(
      'assets/images/tron.png',
      width: 30,
      height: 30,
    ),
  ];

  final List<String> items = [
    'Select BitCoin',
    'Bitcoin',
    'Busd',
    'Etherium',
    'LiteCoin'
  ];
  List bitCoinData = ['', '', '', '', ''];
  String selectedValue = 'Select BitCoin';
  String bitCoin = '';
  String busd = '';
  String etherium = '';
  String liteCoinThther = '';

  IO.Socket socket = IO.io('https://crypto-exchange-usd.onrender.com/', {
    'autoConnect': true,
    'transports': ['websocket'],
  });
  HomeScreenProvider() {
    //streamListener();
    getCriptoData();
  }

  // void streamListener() {
  //   log("checkkk");
  //   channel.stream.listen((message) {
  //     Map data = jsonDecode(message);
  //     btcUsdtPrice = data['p'];
  //     notifyListeners();
  //     print(message);
  //   });
  // }

  void getCriptoData() {
    currencyList = [];

    log("checkkk");

    socket.on('exchange', (data) {
      // Parse the incoming data and add it to the list
      final Map<String, dynamic> dataMap = Map<String, dynamic>.from(data);
      dataMap.forEach((code, value) {
        final currencyData = CurrencyData(code: code, value: value);
        currencyList.add(currencyData);
      });

      // // Optionally, you can print the added data for verification
      // for (var currency in currencyList) {
      //   print('Code: ${currency.code}, Value: ${currency.value}');
      // }
      bitCoinData[1] = currencyList
          .firstWhere(
            (currency) => currency.code == "BTC",
          )
          .value
          .toString();
      notifyListeners();

      bitCoinData[2] = currencyList
          .firstWhere(
            (currency) => currency.code == "BUSD",
          )
          .value
          .toString();

      bitCoinData[3] = currencyList
          .firstWhere(
            (currency) => currency.code == "ETH",
          )
          .value
          .toString();

      bitCoinData[4] = currencyList
          .firstWhere(
            (currency) => currency.code == "LIT",
          )
          .value
          .toString();

      notifyListeners();

      log("check abbkk:$bitCoin");
    });

    socket.on('event', (data) {
      print('Received event: $data');
    });

    socket.on('fromServer', (data) {
      print('Received fromServer event: $data');
    });

    socket.on('disconnect', (_) {
      print('Disconnected');
    });
  }

  dropDownButton(newValue) async {
    log("ttttt:$newValue");
    selectedValue = newValue;
    await showBitCoinData(newValue);
    notifyListeners();
  }

  fixString(String value) {
    if (value.isNotEmpty) {
      log("abbbb $value");
      double d = double.parse(value.toString());
      return d.toStringAsFixed(2);
    }
  }

  showBitCoinData(String value) {
    if (value == "Bitcoin") {
      btcUsdtPrice = currencyList
          .firstWhere(
            (currency) => currency.code == "BTC",
          )
          .value
          .toString();
      notifyListeners();
    } else if (value == "Busd") {
      btcUsdtPrice = currencyList
          .firstWhere(
            (currency) => currency.code == "BUSD",
          )
          .value
          .toString();
    } else if (value == "Etherium") {
      btcUsdtPrice = currencyList
          .firstWhere(
            (currency) => currency.code == "ETH",
          )
          .value
          .toString();
    } else if (value == "LiteCoin") {
      btcUsdtPrice = currencyList
          .firstWhere(
            (currency) => currency.code == "LIT",
          )
          .value
          .toString();
    } else {
      btcUsdtPrice = "";
    }
    notifyListeners();
  }

  @override
  void dispose() {
    channel.sink
        .close(); // Close the WebSocket connection when the provider is disposed.
    socket.disconnect();
    super.dispose();
  }
}
