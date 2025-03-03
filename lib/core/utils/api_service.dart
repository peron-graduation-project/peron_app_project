import 'package:dio/dio.dart';
import 'package:peron_project/features/notification/domain/notification_model.dart';

class ApiService{
  final String _baseUrl='https://sakaniapi1.runasp.net/api/';
  final Dio _dio;

  ApiService(this._dio) ;
  Future<String> sendVerificationCode({required String endPoint })async{
    var response=await _dio.post('$_baseUrl$endPoint');
    return response.data;
  }
  Future<List<NotificationModel>> getNotification({required String endPoint}) async {
    Response response = await _dio.get(endPoint);
    List<dynamic> data = response.data;
    return data.map((json) => NotificationModel.fromJson(json)).toList();
  }

}