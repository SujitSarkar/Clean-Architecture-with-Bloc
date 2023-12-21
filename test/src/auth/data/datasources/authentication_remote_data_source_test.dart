import 'dart:convert';
import 'package:clean_and_bloc/core/errors/exception.dart';
import 'package:clean_and_bloc/core/utils/constants.dart';
import 'package:clean_and_bloc/core/utils/typedef.dart';
import 'package:clean_and_bloc/src/auth/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_and_bloc/src/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('CreateUser', () {
    test('Should complete successfully when the status code is 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201));

      final methodCall = remoteDataSource.createUser;

      expect(methodCall(name: 'name', avatar: 'avatar', createdAt: 'createdAt'),
          completes);

      verify(() => client.post(Uri.parse('$kBaseUrl/$kCreateUserEndpoint'),
          body: jsonEncode({
            'name': 'name',
            'avatar': 'avatar',
            'createdAt': 'createdAt'
          }))).called(1);

      verifyNoMoreInteractions(client);
    });

    test('Should throw [APIException] when the status code is not 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (invocation) async => http.Response('Invalid email address', 400));

      final methodCall = remoteDataSource.createUser;

      expect(
          () async => methodCall(
              name: 'name', avatar: 'avatar', createdAt: 'createdAt'),
          throwsA(const APIException(
              message: 'Invalid email address', statusCode: 400)));

      verify(() => client.post(Uri.parse('$kBaseUrl/$kCreateUserEndpoint'),
          body: jsonEncode({
            'name': 'name',
            'avatar': 'avatar',
            'createdAt': 'createdAt'
          }))).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('GetUsers', () {
    const tUsers = [UserModel.empty()];

    test('Should return [List<User>] when the status code is 200', () async {
      when(() => client.get(any())).thenAnswer((invocation) async {
        DataMap map = tUsers.first.toMap();
        return http.Response(jsonEncode(map), 200);
      });

      final result = await remoteDataSource.getUser();

      expect(result, tUsers);

      verify(()=> client.get(Uri.parse('$kBaseUrl$kGetUserEndpoint'))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
