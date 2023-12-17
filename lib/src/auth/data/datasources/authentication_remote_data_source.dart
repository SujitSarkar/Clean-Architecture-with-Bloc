import '../models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt});

  Future<List<UserModel>> getUser();
}
