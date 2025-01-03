import 'package:async_value_with_switch_sample/data/sources/local/isar.dart';
import 'package:async_value_with_switch_sample/domains/entities/user.dart';
import 'package:async_value_with_switch_sample/domains/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

abstract interface class UserRepositoryBase {
  /// 全てのUser情報を検索する
  Future<List<User>> findAll();

  /// Userを保存する
  Future<void> save(User user);

  /// Userを削除する
  Future<void> delete(int userId);

  /// 全てのUserを削除する
  Future<void> deleteAll();

  /// 複数のUserを保存する
  Future<void> saveBatch(List<User> users);

  /// 複数のUserを削除する
  Future<void> deleteBatch(List<int> userIds);

  // Userコレクションを監視する
  Stream<List<User>> watch();
}

class UserRepository implements UserRepositoryBase {
  UserRepository(this.ref);

  final Ref ref;

  @override
  Future<void> save(User user) async {
    final isar = await ref.read(isarProvider.future);
    final userEntity = user.toEntity();
    await isar.writeTxn(() async {
      await isar.userEntitys.put(userEntity);
    });
  }

  @override
  Future<void> delete(int userId) async {
    final isar = await ref.read(isarProvider.future);
    await isar.writeTxn(() async {
      await isar.userEntitys.delete(userId);
    });
  }

  @override
  Future<List<User>> findAll() async {
    final isar = await ref.read(isarProvider.future);
    final userEntitys = await isar.userEntitys.where().findAll();
    return userEntitys.map((entity) => entity.toDomain()).toList();
  }

  @override
  Future<void> deleteAll() async {
    final isar = await ref.read(isarProvider.future);
    await isar.writeTxn(() async {
      await isar.userEntitys.clear();
    });
  }

  @override
  Future<void> saveBatch(List<User> users) async {
    final isar = await ref.read(isarProvider.future);
    final userEntities = users.map((user) => user.toEntity()).toList();

    await isar.writeTxn(() async {
      await isar.userEntitys.putAll(userEntities);
    });
  }

  @override
  Future<void> deleteBatch(List<int> userIds) async {
    final isar = await ref.read(isarProvider.future);

    await isar.writeTxn(() async {
      await isar.userEntitys.deleteAll(userIds);
    });
  }

  @override
  Stream<List<User>> watch() async* {
    final isar = await ref.read(isarProvider.future);
    // watchLazy で変更を監視
    final userStream = isar.userEntitys.watchLazy(fireImmediately: true);
    await for (final _ in userStream) {
      yield await findAll();
    }
  }
}

extension UserEntityMapper on UserEntity {
  /// UserEntityからUserへの変換
  User toDomain() {
    return User(
      id: id,
      name: name,
      age: age,
      isDrinkingAlcohol: isDrinkingAlcohol,
      homeTown: homeTown,
    );
  }
}

extension UserMapper on User {
  /// UserからUserEntityへの変換
  UserEntity toEntity() {
    return UserEntity()
      ..id = id ?? Isar.autoIncrement
      ..name = name
      ..age = age
      ..isDrinkingAlcohol = isDrinkingAlcohol
      ..homeTown = homeTown;
  }
}
