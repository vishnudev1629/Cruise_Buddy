import 'package:cruise_buddy/core/services/auth/auth_services.dart';
import 'package:cruise_buddy/core/services/cruise/cruise_service.dart';
import 'package:cruise_buddy/core/services/location/location_service.dart';
import 'package:cruise_buddy/core/view_model/getCruiseTypes/get_cruise_types_bloc.dart';
import 'package:cruise_buddy/core/view_model/getFeaturedBoats/get_featured_boats_bloc.dart';
import 'package:cruise_buddy/core/view_model/getLocationDetails/get_location_details_bloc.dart';
import 'package:cruise_buddy/core/view_model/getUserProfile/get_user_profile_bloc.dart';
import 'package:cruise_buddy/core/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiTest extends StatelessWidget {
  const ApiTest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetCruiseTypesBloc, GetCruiseTypesState>(
      listener: (context, state) {
        state.map(
          initial: (value) {
            print(value);
          },
          loading: (value) {
            print(value);
          },
          getCruiseTypes: (value) {
            print(value);
          },
          getCruiseTypesFailure: (value) {
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
                  BlocProvider.of<GetCruiseTypesBloc>(context)
                      .add(GetCruiseTypesEvent.getCruiseTypes());
                  //  await CruiseService().getCruiseTypes();
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
