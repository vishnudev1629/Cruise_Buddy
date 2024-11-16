part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.started() = _Started;
  const factory RegisterEvent.loginRequested({
    required String email,
    required String password,
  }) = _RegisterRequested;
}
