// @dart=2.9
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'Model.dart';

void main() {
  var client  = http.Client();
  String cid = "bafybeie655yeevcvhjikvfmz62ycijisbij3tedxugpadcqwi5kjvtrr5y";
  String baseUrl = "https://$cid.ipfs.dweb.link/";
  String fileName = "DeAI-model.json";
  group("IPFS", (){
    test("Fetch the file from IPFS",() async{
    
      dynamic response = await client.get(Uri.parse(baseUrl+fileName));
      if(response.statusCode!=200)
        print("Fetching Failure");
      else {
        Model model = Model.fromJson(response.body);
        print(model.toString());
    }
  });
});
}
