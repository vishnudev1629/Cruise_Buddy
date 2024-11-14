import 'package:cruise_buddy/core/services/api_services.dart';
import 'package:cruise_buddy/core/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiTest extends StatelessWidget {
  const ApiTest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        state.map(initial: (_) {
          print('initial');
        }, loading: (_) {
          print('loading');
        }, loginSuccess: (success) {
          print('xxxxxxxxxxxxxxxxxx ${success.loginModel.user?.email}');
        }, loginFailure: (success) {
          print('failed');
        });
      },
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  BlocProvider.of<LoginBloc>(context).add(
                    LoginEvent.loginRequested(
                      email: 'email',
                      password: 'password',
                    ),
                  );
                },
                child: Text("Call Api"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
