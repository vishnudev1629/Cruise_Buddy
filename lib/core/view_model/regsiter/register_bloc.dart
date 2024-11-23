import 'package:bloc/bloc.dart';
import 'package:cruise_buddy/core/model/registration_model/registration_model.dart';
import 'package:cruise_buddy/core/services/auth/auth_services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(_Initial()) {
    AuthServices apiServices = AuthServices();
    on<_RegisterRequested>((event, emit) async {
      emit(const RegisterState.loading());

      try {
        final result = await apiServices.register(
          name: event.name,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );

        await result.fold((failure) async {
          emit(RegisterState.registrationFailure(error: failure.toString()));
        }, (success) async {
          // var accessToken = await SetSharedPreferences.storeAccessToken(
          //         success.misc.accessToken) ??
          //     'Access Token empty';
          emit(RegisterState.registrationSuccess(registerModel: success));
        });
      } catch (e) {
        emit(RegisterState.registrationFailure(error: 'An error occurred: $e'));
      }
    });
  }
}
