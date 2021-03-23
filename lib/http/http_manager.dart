import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

//设置为全局变量
Dio dio = new Dio(BaseOptions());

void initDio() {
  //在这里对Dio作进一步的配置
  dio.interceptors.add(LogInterceptor());
  //自定义转换器
  (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}
