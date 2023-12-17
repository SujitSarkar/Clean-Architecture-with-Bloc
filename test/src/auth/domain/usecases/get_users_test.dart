import 'package:clean_and_bloc/src/auth/domain/entities/user.dart';
import 'package:clean_and_bloc/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_and_bloc/src/auth/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUsers useCase;

  setUp(() {
    repository = MockAuthRepo();
    useCase = GetUsers(repository);
  });

  const tResponse = [User.empty()];

  test(
      'Should call [AuthenticationRepository.getUsers] and return [List<Users>]',
      () async {
        //Arrange
        when(()=>repository.getUsers()).thenAnswer((invocation) async => const Right(tResponse));

        //Act
        final result = await useCase();

        //Assert
        expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
        verify(()=> repository.getUsers()).called(1);
        verifyNoMoreInteractions(repository);
      });
}
