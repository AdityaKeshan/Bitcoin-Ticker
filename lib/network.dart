import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class NetworkData
{

  static const String API_KEY="8F1DB1F7-C942-402A-9BDF-6AD06D7FC9F7";
  Future<dynamic> getData({String coin,String curr}) async
  {
    Map<String,String> options = {
     'X-CoinAPI-Key': '$API_KEY'
    };
    http.Response response=await http.get("https://rest.coinapi.io/v1/exchangerate/$coin/$curr",headers:options );
    if(response.statusCode==200)
      {
        print(response.body);
        return jsonDecode(response.body);
      }
    else
      {
        return response.statusCode;
      }
  }
}