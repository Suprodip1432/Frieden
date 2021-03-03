import 'dart:convert';

import 'package:http/http.dart' as http;
class RequestAssistant
{
  static Future<dynamic> getRequest(String url) async
  {
    http.Response response = await http.get(url);

    try
        {
          if(response.statusCode == 200)
          {
            String jSondata = response.body;
            var dcodeData =jsonDecode(jSondata);
            return dcodeData;

          }
          else
          {
            return "Failed.";
          }
        }
    catch(exp)
    {
      return "Failed.";

    }
  }
}