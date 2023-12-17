// What does the class depend on
// Ans. AuthenticationRepository
// How can we create a fake version of the dependency
// Ans. Use Mocktail
// How do we control what our dependencies do
// Ans. Using the Mocktail's APIs

import 'package:clean_and_bloc/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_and_bloc/src/auth/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'authentication_repository.mock.dart';


void main() {
  late CreateUser useCase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    useCase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();
  test('Should call the  [AuthenticationRepository.createUser]', () async {
    //Arrange
    //STUB
    when(() => repository.createUser(
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
            createdAt: any(named: 'createdAt')))
        .thenAnswer((invocation) async => const Right(null));

    //Act
    final result = await useCase(params);

    //Assert
    expect(result, const Right<dynamic, void>(null));
    verify(() => repository.createUser(
        name: params.name,
        avatar: params.avatar,
        createdAt: params.createdAt)).called(1); //Called once

    verifyNoMoreInteractions(repository);
  });
}
