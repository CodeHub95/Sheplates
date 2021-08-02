import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/Utils/Routes.dart';
import 'package:flutter_sheplates/Utils/app_constants.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  Dio dio;

  NetworkUtil.internal() {
    //for live app
    // dio = Dio()..options.baseUrl = "http://ec2-13-235-86-192.ap-south-1.compute.amazonaws.com:5000/api/v1/";
    //for testing
    dio = Dio()..options.baseUrl = "http://13.235.23.140:5000/api/v1/";
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  factory NetworkUtil() => _instance;

  Future<dynamic> post(
      {Key key, String url, var body, String token, bool isFormData: false, BuildContext context}) async {
    Map<String, String> map = new Map();

    if (!isFormData) {
//      map["Content-Type"] = "application/json";
    } else {
//      map["Content-Type"] = "multipart/form-data";
      map["Accept"] = "application/json";
    }
    if (token != null) {
      map["Authorization"] = "Bearer " + token;
    }

    Options options = Options(headers: map, contentType: isFormData ? "multipart/form-data" : "application/json");

    return await dio.post(Uri.encodeFull(url), data: body, options: options).then((response) async {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401) {
          throw new Exception("401");
        } else {
          throw new Exception("Error while fetching data");
        }
      }
      return response.data;
    }).catchError((errorResponse) {
      if (errorResponse.subscriptionData.statusCode == 404) {
        // logout(context);
      }
      return errorResponse.subscriptionData.data;
    });
  }

  Future<dynamic> deleteApi(String url, {String token, body}) {
    Map<String, String> map = new Map();
    map["Content-Type"] = "application/json";
    if (token != null) {
      map["Authorization"] = "Bearer " + token;
    }

    Options options = Options(headers: map);

    return dio.delete(url, options: options).then((response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401) {
          throw new Exception("401");
        } else {
          throw new Exception("Error while fetching data");
        }
      }
      return response.data;
    }).catchError((errorResponse) {
      return errorResponse.subscriptionData.data;
    });
  }

  Future<dynamic> get(String url, {String token, queryMap, BuildContext context}) {
    Map<String, String> map = new Map();
    Map<String, dynamic> queryParams = new Map();
    map["Content-Type"] = "application/json";
    if (token != null) {
      map["Authorization"] = "Bearer " + token;
    }

    if (queryMap != null) {
      queryParams = queryMap;
    }

    Options options = new Options(headers: map);

    return dio.get(Uri.encodeFull(url), options: options, queryParameters: queryParams).then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401) {
          throw new Exception("401");
        } else {
          throw new Exception("Error while fetching data");
        }
      }
      return response.data;
    }).catchError((errorResponse) {
      if (errorResponse.subscriptionData.statusCode == 401) {
        // logout(context);
      }
      return errorResponse.subscriptionData.data;
    });
  }

  Future<dynamic> putApi({body, String url, String token, bool isFormData: false}) {
    Map<String, String> map = new Map();

    if (!isFormData) {
//      map["Content-Type"] = "application/json";
    } else {
//      map["Content-Type"] = "multipart/form-data";
      map["Accept"] = "application/json";
    }

    if (token != null) {
      map["Authorization"] = "Bearer " + token;
    }

    Options options = Options(headers: map, contentType: isFormData ? "multipart/form-data" : "application/json");
    return dio.put(url, data: body, options: options).then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 500 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.data;
    }).catchError((error) {
      return error.subscriptionData.data;
    });
  }

  Future<dynamic> getBaseUrl(String url, {String token, queryMap}) {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    Map<String, String> map = new Map();
    Map<String, dynamic> queryParams = new Map();
    map["Content-Type"] = "application/json";
    if (token != null) {
      map["Authorization"] = "Bearer " + token;
    }

    if (queryMap != null) {
      queryParams = queryMap;
    }

    Options options = new Options(headers: map);

    return dio.get(Uri.encodeFull(url), options: options, queryParameters: queryParams).then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401) {
          throw new Exception("401");
        } else {
          throw new Exception("Error while fetching data");
        }
      }
      return response.data;
    }).catchError((errorResponse) {
      return errorResponse.subscriptionData.data;
    });
  }

//  logout(BuildContext context) async {
//    try {
//      SharedPreferences pref = await SharedPreferences.getInstance();
//
//      String startResponse = await SharedPrefHelper().getWithDefault(
//          SharedPrefConstants.startResponse, jsonEncode(StartResponse()));
//
//      await pref.clear();
//
//      await SharedPrefHelper()
//          .save(SharedPrefConstants.startResponse, startResponse);
//
//      Navigator.pushNamedAndRemoveUntil(
//          context, Routes.registerSignInRoute, (Route<dynamic> route) => false);
//    } catch (e) {}
//  }
}
