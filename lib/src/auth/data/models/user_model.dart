import 'dart:convert';
import 'package:clean_and_bloc/src/auth/domain/entities/user.dart';
import '../../../../core/utils/typedef.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.name,
      required super.avatar,
      required super.createdAt});

  const UserModel.empty()
      : this(
            id: '1',
            name: '_empty.name',
            avatar: '_empty.avatar',
            createdAt: '_empty.createdAt');

  UserModel copyWith(
      {String? id, String? name, String? createdAt, String? avatar}) {
    return UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt);
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
            id: map['id'] as String,
            name: map['name'] as String,
            avatar: map['avatar'] as String,
            createdAt: map['createdAt'] as String);

  DataMap toMap() =>
      {'id': id, 'name': name, 'avatar': avatar, 'createdAt': createdAt};

  String toJson() => jsonEncode(toMap());
}
