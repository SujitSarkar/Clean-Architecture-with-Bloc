import 'package:clean_and_bloc/core/utils/typedef.dart';
import 'package:clean_and_bloc/src/auth/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture createUser(
      {required String name,
      required String avatar,
      required String createdAt});

  ResultFuture<List<User>> getUsers();
}
