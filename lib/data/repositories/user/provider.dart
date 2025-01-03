import 'package:async_value_with_switch_sample/data/repositories/user/repository.dart';
import 'package:async_value_with_switch_sample/domains/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
UserRepositoryBase userRepository(Ref ref) {
  return UserRepository(ref);
}

@riverpod
Stream<List<User>> userList(Ref ref) {
  return ref.read(userRepositoryProvider).watch();
}
