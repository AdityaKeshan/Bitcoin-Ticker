import 'package:bitcoin_ticker/network.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selected="USD";
  String btc;
  String ltc;
  String eth;
  NetworkData nd=new NetworkData();
  void getRate() async
  {
    btc="?";
    ltc="?";
    eth="?";
    var data=await nd.getData(coin: 'BTC',curr: selected);
    var data1=await nd.getData(coin: 'LTC',curr: selected);
    var data2=await nd.getData(coin: 'ETH',curr: selected);
    setState(() {
      btc=(data['rate'].round()).toString();
      ltc=(data1['rate'].round()).toString();
      eth=(data2['rate'].round()).toString();
    });
  }
  DropdownButton getDropdown()
  {
    List<DropdownMenuItem<String>> ans=[];
    for(int i=0;i<currenciesList.length;i++)
    {
      ans.add( DropdownMenuItem(child: Text(currenciesList[i]),value: currenciesList[i],),);
    }

    return DropdownButton<String>(
    value: selected,
    items:ans,
    onChanged: (String val)
    {
    setState(() {
    selected=val;
    getRate();

    });
    },
    );
  }
  Widget iosPicker()
  {
    List<Widget> ans=[];
    for(int i=0;i<currenciesList.length;i++)
    {
      ans.add( Text(currenciesList[i]));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex)
      {
        selected=currenciesList[selectedIndex];
        getRate();
      },
      children: ans,
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRate();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $btc $selected',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $eth $selected',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $ltc $selected',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:Platform.isIOS ? iosPicker():getDropdown(),
          ),
        ],
      ),
    );
  }
}
