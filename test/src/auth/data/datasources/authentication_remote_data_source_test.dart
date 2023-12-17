import 'package:clean_and_bloc/core/errors/exception.dart';
import 'package:clean_and_bloc/core/errors/failure.dart';
import 'package:clean_and_bloc/src/auth/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_and_bloc/src/auth/data/repositories/auth_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repositoryImplementation;

  const tException = APIException(
      message: 'Internal server error', statusCode: 500);

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repositoryImplementation =
        AuthenticationRepositoryImplementation(remoteDataSource);
  });

  group('createUser', () {
    const String name = 'whatever.name';
    const String avatar = 'whatever.avatar';
    const String createdAt = 'whatever.createdAt';

    test(
        'Should call the [AuthenticationRemoteDataSource.createUser] and complete '
        'successfully when the call to the source is successful', () async {
      // Arrange
      when(() => remoteDataSource.createUser(
              name: any(named: 'name'),
              avatar: any(named: 'avatar'),
              createdAt: any(named: 'createdAt')))
          .thenAnswer((invocation) async => Future.value());

      // Act
      final result = await repositoryImplementation.createUser(
          name: name, avatar: avatar, createdAt: createdAt);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(
          name: name, avatar: avatar, createdAt: createdAt)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'Should return a [ServerFailure] when the call to the remote '
        'source is successful', () async {
      // Arrange
      when(() => remoteDataSource.createUser(
              name: any(named: 'name'),
              avatar: any(named: 'avatar'),
              createdAt: any(named: 'createdAt')))
          .thenThrow(tException);

      // Act
      final result = await repositoryImplementation.createUser(
           name: name, avatar: avatar, createdAt: createdAt);

      // Assert
      expect(
          result,
          equals(Left(
              APIFailure(message: tException.message, statusCode: tException.statusCode))));

       verify(()=>remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt)).called(1);
       verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () { });
}
