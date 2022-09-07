import 'package:dio/dio.dart';

class UsersServices {
  Future<dynamic> getUsers({required int limit, required int skip}) async {
    final dio = Dio();
    const baseUrl = 'https://dummyjson.com';
    try {
      final response = await dio.get('$baseUrl/users?limit=$limit&skip=$skip');
      if (response.statusCode == 200) {
        return response.data;
      }
      throw response.data.toString();
    } catch (e) {
      rethrow;
    }
  }
}
