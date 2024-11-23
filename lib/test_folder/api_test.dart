import 'package:cruise_buddy/core/services/auth/auth_services.dart';
import 'package:cruise_buddy/core/view_model/getUserProfile/get_user_profile_bloc.dart';
import 'package:cruise_buddy/core/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiTest extends StatelessWidget {
  const ApiTest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetUserProfileBloc, GetUserProfileState>(
      listener: (context, state) {
        state.map(
          initial: (value) {
            print(value);
          },
          loading: (value) {
            print(value);
          },
          getuseruccess: (value) {
            print(value);
          },
          getuserFailure: (value) {
            print(value);
          },
          noInternet: (value) {
            print(value);
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  BlocProvider.of<GetUserProfileBloc>(context)
                      .add(GetUserProfileEvent.getUserProfile());
                  //     AuthServices().register('name', 'email', 'password');
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
