import 'dart:convert';

import 'package:dio/dio.dart';

class CallApi {
  Dio dio;
  final String _url =
      'http://10.0.2.2:5000/submit'; /*'http://127.0.0.1:5000/submit';*/

  postData(data) async {
    var fullUrl = _url;
    setHeaders();
    return await dio.post(Uri.encodeFull(fullUrl), data: json.encode(data));
  }

  setHeaders() {
    dio = new Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['accept'] = 'application/json';
  }
}
