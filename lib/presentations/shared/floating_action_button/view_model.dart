import 'package:async_value_with_switch_sample/data/repositories/user/provider.dart';
import 'package:async_value_with_switch_sample/data/repositories/user/repository.dart';
import 'package:async_value_with_switch_sample/domains/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@Riverpod(keepAlive: true)
class EditUserActionViewModel extends _$EditUserActionViewModel {
  @override
  void build() {}

  UserRepositoryBase get userRepository => ref.read(userRepositoryProvider);

  /// ユーザー情報の作成
  Future<void> create() async {
    final user = User.random();

    await ref.read(userRepositoryProvider).save(user);
  }

  /// 複数のユーザー情報を作成する
  Future<void> createBatch() async {
    const number = 500;
    final users = List.generate(number, (_) => User.random());

    await ref.read(userRepositoryProvider).saveBatch(users);
  }

  /// ユーザー情報の初期化
  Future<void> initUser() async {
    await ref.read(userRepositoryProvider).deleteAll();
  }

  /// ユーザーをランダムで１０こ削除する
  Future<void> deleteBatch() async {
    const number = 10;
    final users = await userRepository.findAll();

    final userIds = users
        .map((user) => user.id)
        .whereType<int>()
        .take(number)
        .map((id) => id)
        .toList();

    if (userIds.isEmpty) return;

    await ref.read(userRepositoryProvider).deleteBatch(userIds);
  }
}
