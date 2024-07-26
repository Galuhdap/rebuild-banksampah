import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

final dio = new Dio(BaseOptions(
  contentType: 'application/json',
  responseType: ResponseType.plain,
));

abstract class ApiService {
  Future<dynamic> get(
      String endpoint, {
        Map<String, String>? queryParameter,
      }) async {
    try {
      Response response =
      await dio.get(endpoint, queryParameters: queryParameter);
      inspect(response);

      final rawResponse = jsonDecode(response.toString());
      return rawResponse;
    } catch (ex) {
      print(ex.toString());
      throw (Exception("Connection Failed !"));
    }
  }

  Future<dynamic> post(
      String endpoint, {
        Map<String, String>? queryParameter,
        Map<String, String>? header,
        Map<String, String>? body,
      }) async {
    try {
      Response response = await dio.post(
        endpoint,
        queryParameters: queryParameter,
        data: body,
        options: Options(headers: header),
      );

      inspect(response);

      final rawResponse = jsonDecode(response.toString());
      return rawResponse;
    } on Exception {
      throw (Exception("Connection Failed !"));
    }
  }
}