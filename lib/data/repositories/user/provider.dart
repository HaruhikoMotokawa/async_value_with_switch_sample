import 'package:async_value_with_switch_sample/core/log/logger.dart';
import 'package:async_value_with_switch_sample/data/repositories/user/repository.dart';
import 'package:async_value_with_switch_sample/domains/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
UserRepositoryBase userRepository(Ref ref) => UserRepository(ref);

@riverpod
Stream<List<User>> userList(Ref ref) {
  // 廃棄された時にlogを流す
  ref.onDispose(() {
    logger.i('userList disposed');
  });
  return ref.read(userRepositoryProvider).watch();
}
