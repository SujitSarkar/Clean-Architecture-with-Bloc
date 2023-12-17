import 'dart:convert';
import 'package:clean_and_bloc/core/utils/typedef.dart';
import 'package:clean_and_bloc/src/auth/data/models/user_model.dart';
import 'package:clean_and_bloc/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel= UserModel.empty();

  test('Should be a subclass of [User] entity', () {
    //Arrange
    //Act
    //Assert
    expect(tModel, isA<User>() );
  });

  final String tJson = fixture('user.json');
  final DataMap tMap = jsonDecode(tJson);

  group('fromMap', () {
    test('Should return a [UserModel] with the right data', (){
      //Act
      final result = UserModel.fromMap(tMap);

      //Assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('Should return a [UserModel] with the right data', (){
      //Act
      final result = UserModel.fromJson(tJson);

      //Assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('Should return a [UserModel] with the right data', (){
      //Act
      final result = tModel.toMap();

      //Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('Should return a [UserModel] with the right data', (){
      //Act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "name": "_empty.name",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt"
      });

      //Assert
      expect(result, equals(tJson));
    });
  });

  group('toMap', () {
    test('Should return a [UserModel] with the right data', (){
      //Act
      final result = tModel.toMap();

      //Assert
      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test('Should return a [UserModel] with the right data', (){
      //Act
      final result = tModel.copyWith(name: 'Nipol');

      //Assert
      expect(result.name, equals('Nipol'));
    });
  });
}