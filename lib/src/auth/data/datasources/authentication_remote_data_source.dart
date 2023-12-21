import 'dart:convert';
import 'package:clean_and_bloc/core/errors/exception.dart';
import 'package:clean_and_bloc/core/utils/constants.dart';
import 'package:clean_and_bloc/core/utils/typedef.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt});

  Future<List<UserModel>> getUser();
}

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt}) async {
    try {
      final http.Response response = await _client.post(
          Uri.parse('$kBaseUrl/$kCreateUserEndpoint'),
          body: jsonEncode(
              {'name': 'name', 'avatar': 'avatar', 'createdAt': 'createdAt'}));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUser() async {
    final response =
        await _client.get(Uri.parse('$kBaseUrl$kGetUserEndpoint'));
    print(jsonDecode(response.body));

    return List<DataMap>.from(jsonDecode(response.body))
        .map((DataMap userData) => UserModel.fromMap(userData))
        .toList();
  }
}
