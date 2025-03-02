import 'package:dio/dio.dart';

class ApiService{
  final String _baseUrl='https://sakaniapi1.runasp.net/api/';
  final Dio _dio;

  ApiService(this._dio) ;
  Future<String> sendVerificationCode({required String endPoint })async{
    var response=await _dio.post('$_baseUrl$endPoint');
    return response.data;
  }
}