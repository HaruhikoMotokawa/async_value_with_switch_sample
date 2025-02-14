// ignore_for_file: constant_identifier_names, public_member_api_docs

import 'package:async_value_with_switch_sample/domains/models/home_town.dart';
import 'package:isar/isar.dart';

part 'user.g.dart'; // Isarコードジェネレーターが生成するファイル

/// Isarで扱うユーザーの情報の型
// Isarのエンティティクラスには、@collectionをつける
@collection
// @nameをつけることで、Isarのコレクション名を指定できる
@Name('User')
class UserEntity {
  // IsarのautoIncrementを使うことで、自動採番を行うことができる
  Id id = Isar.autoIncrement;
  late String name;
  late int age;
  late bool isDrinkingAlcohol;
  // EnumTypeを指定することで、列挙型を保存できる
  @Enumerated(EnumType.name)
  late HomeTown homeTown;
}
