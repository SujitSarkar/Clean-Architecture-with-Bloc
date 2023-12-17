import 'package:clean_and_bloc/core/usecase/usecase.dart';
import 'package:clean_and_bloc/core/utils/typedef.dart';
import 'package:clean_and_bloc/src/auth/domain/entities/user.dart';
import 'package:clean_and_bloc/src/auth/domain/repositories/auth_repository.dart';

class GetUsers extends UseCaseWithoutParams<List<User>>{
  final AuthenticationRepository _repository;
  const GetUsers(this._repository);

  @override
  ResultFuture<List<User>> call() async => await _repository.getUsers();
}