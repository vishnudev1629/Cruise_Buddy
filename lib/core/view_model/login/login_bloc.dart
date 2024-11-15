import 'package:bloc/bloc.dart';
import 'package:cruise_buddy/core/model/login_model/login_model.dart';
import 'package:cruise_buddy/core/services/api_services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(_Initial()) {
    ApiServices apiServices = ApiServices();
    on<_LoginRequested>((event, emit) async {
      emit(const LoginState.loading());

      try {
        final result = await apiServices.login(
          email: event.email,
          password: event.password,
        );

        await result.fold((failure) async {
          emit(LoginState.loginFailure(error: failure.toString()));
        }, (success) async {
          // var accessToken = await SetSharedPreferences.storeAccessToken(
          //         success.misc.accessToken) ??
          //     'Access Token empty';
          emit(LoginState.loginSuccess(loginModel: success));
        });
      } catch (e) {
        emit(LoginState.loginFailure(error: 'An error occurred: $e'));
      }
    });
  }
}
