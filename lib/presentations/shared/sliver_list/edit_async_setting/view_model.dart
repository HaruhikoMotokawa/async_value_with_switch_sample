import 'package:async_value_with_switch_sample/data/repositories/user/provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.freezed.dart';
part 'view_model.g.dart';

@freezed
class AsyncSettingState with _$AsyncSettingState {
  const factory AsyncSettingState({
    required bool skipLoadingOnReload,
    required bool skipLoadingOnRefresh,
    required bool skipError,
  }) = _AsyncSettingState;
}

@Riverpod(keepAlive: true)
class AsyncSettingViewModel extends _$AsyncSettingViewModel {
  @override
  AsyncSettingState build() {
    return const AsyncSettingState(
      skipLoadingOnReload: false,
      skipLoadingOnRefresh: true,
      skipError: false,
    );
  }

  void changeAsyncSetting({
    bool? skipLoadingOnReload,
    bool? skipLoadingOnRefresh,
    bool? skipError,
  }) {
    state = AsyncSettingState(
      skipLoadingOnReload: skipLoadingOnReload ?? state.skipLoadingOnReload,
      skipLoadingOnRefresh: skipLoadingOnRefresh ?? state.skipLoadingOnRefresh,
      skipError: skipError ?? state.skipError,
    );
  }

  void invalidate() => ref.invalidate(userListProvider);
}
