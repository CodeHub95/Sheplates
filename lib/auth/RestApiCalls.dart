import 'package:flutter_sheplates/Utils/NetworkUtils.dart';
import 'package:flutter_sheplates/modals/response/BaseResponse.dart';
import 'package:flutter_sheplates/modals/response/HolidayListResponse.dart';

import 'api_config.dart';

class RestApiCalls {
  static RestApiCalls _instance = new RestApiCalls.internal();
  NetworkUtil net;

  RestApiCalls.internal() {
    net = NetworkUtil();
  }

  factory RestApiCalls() => _instance;

  Future<BaseResponse> addDeliveryAddress(var body, String token) async {
    return net
        .post(url: ApiConfig.addDeliveryAddress, body: body, token: token)
        .then((value) {
      return BaseResponse.fromJson(value);
    });
  }

  Future<BaseResponse> confirmDeliveryAddress(var body, String token) async {
    return net
        .post(url: ApiConfig.userConfirmLocation, body: body, token: token)
        .then((value) {
      return BaseResponse.fromJson(value);
    });
  }

  Future<BaseResponse> userAddUserRequest(var body, String token) async {
    return net
        .post(url: ApiConfig.userAddUserRequest, body: body, token: token)
        .then((value) {
      return BaseResponse.fromJson(value);
    });
  }

  Future<BaseResponse> logout(var body, String token) async {
    return net
        .post(url: ApiConfig.userLogout, body: body, token: token)
        .then((value) {
      return BaseResponse.fromJson(value);
    });
  }

  Future<HolidayListResponse> getHolidayList(String token) async {
    return net.get(ApiConfig.getHolidayList, token: token).then((value) {
      return HolidayListResponse.fromJson(value);
    });
  }

  Future<BaseResponse> userUpdateLastSeen(String token) async {
    return net.putApi(url: ApiConfig.userLogout, token: token).then((value) {
      return BaseResponse.fromJson(value);
    });
  }
}
