import 'package:bloc/bloc.dart';
import 'package:clean_and_bloc/src/auth/domain/usecases/create_user.dart';
import 'package:clean_and_bloc/src/auth/domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthState> emit) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      name: event.name,
      avatar: event.avatar,
      createdAt: event.createdAt,
    ));

    result.fold((failure) => emit(AuthError(message: failure.errorMessage)),
        (r) => emit(const UserCreated()));
  }

  Future<void> _getUsersHandler(
      GetUsersEvent event, Emitter<AuthState> emit) async {
    emit(const GettingUser());

    final result = await _getUsers();

    result.fold((failure) => emit(AuthError(message: failure.errorMessage)),
        (users) => emit(UserLoaded(users: users)));
   }
}
