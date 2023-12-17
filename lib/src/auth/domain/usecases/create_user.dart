import 'package:clean_and_bloc/core/usecase/usecase.dart';
import 'package:clean_and_bloc/core/utils/typedef.dart';
import 'package:clean_and_bloc/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture call(CreateUserParams params) async => _repository.createUser(
      name: params.name, avatar: params.avatar, createdAt: params.createdAt);
}

class CreateUserParams extends Equatable {
   final String name;
  final String createdAt;
  final String avatar;

  const CreateUserParams(
      {required this.name, required this.createdAt, required this.avatar});

   const CreateUserParams.empty()
      : this(
            name: '_empty.name',
            createdAt: '_empty.createdAt',
            avatar: '_empty.avatar');

  @override
  List<Object?> get props => [name, avatar, createdAt];
}
