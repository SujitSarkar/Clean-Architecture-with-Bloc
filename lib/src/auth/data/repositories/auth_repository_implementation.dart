import 'package:clean_and_bloc/core/errors/exception.dart';
import 'package:clean_and_bloc/core/errors/failure.dart';
import 'package:clean_and_bloc/core/utils/typedef.dart';
import 'package:clean_and_bloc/src/auth/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_and_bloc/src/auth/domain/entities/user.dart';
import 'package:clean_and_bloc/src/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultFuture createUser(
      {required String name,
      required String avatar,
      required String createdAt}) async {
    // Test-Driven development
    // Cal the remote data source
    // Check if the method returns the proper data
    // Check if when the remoteDataSource thrown an exception, we returns a
    // failure and if doesn't throw an exception, we return the actual
    // excepted data

    try {
      await _remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async{
    try {
      final result = await _remoteDataSource.getUser();
      return Right(result);
    } on APIException catch (e) {
     return Left(APIFailure.fromException(e));
    }
  }
}
