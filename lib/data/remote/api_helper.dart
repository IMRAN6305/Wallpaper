import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as httpClient;
import 'package:myapp/data/remote/app_exceptions.dart';

class ApiHelper {
  Future<dynamic> getApi({required String url}) async {
    var uri = Uri.parse(url);

    try {
      var res = await httpClient.get(uri,headers: {"Authorization":"OZktfHu4fbQxDPTm4vGtkE2Hssaj0EYLYUKDfcqJqsnCU23PzXoMZ2Yw"});
      
      return returnJsonResponse(res);
    } on SocketException catch (e) {
      throw (FeatchDataException(errormsg: 'No Internet!'));
    }
  }

  dynamic returnJsonResponse(httpClient.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var mdata = jsonDecode(response.body);
          return mdata;
        }
      case 400:
        throw BadRequestException(errormsg: response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(errormsg: response.body.toString());
      case 404:
        throw InvalidInputException(errormsg: response.body.toString());
      case 500:
      default:
        throw FeatchDataException(
            errormsg:
                "Error occured while communicating with the server: ${response.statusCode}");
    }
  }


///                      Post request

  // Future<dynamic> postApi(
  //     {required String url, Map<String, dynamic>? bodyParams}) async {
  //   var uri = Uri.parse(url);
  //   var res = await httpClient.post(uri, body: bodyParams ?? {});
  //   if (res.statusCode == 200) {
  //     var mdata = jsonDecode(res.body);
  //     return mdata;
  //   } else {
  //     return null;
  //   }
  // }
}