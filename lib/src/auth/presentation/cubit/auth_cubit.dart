import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/get_users.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt}) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      name: name,
      avatar: avatar,
      createdAt: createdAt,
    ));

    result.fold((failure) => emit(AuthError(message: failure.errorMessage)),
        (r) => emit(const UserCreated()));
  }

  Future<void> getUsers() async {
    emit(const GettingUser());

    final result = await _getUsers();

    result.fold((failure) => emit(AuthError(message: failure.errorMessage)),
            (users) => emit(UserLoaded(users: users)));
  }
}
