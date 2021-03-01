import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';

class NetworkHelper{

  NetworkHelper({@required this.url});

  final String url;


  Future getData()async
  {
    http.Response response= await http.get(url);

   String data=response.body;

   if(response.statusCode==200){
     var decodeData;
     decodeData=jsonDecode(data);
    return decodeData;
   }else {
     print(response.statusCode);
   }
  }
}