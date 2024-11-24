import 'package:cruise_buddy/core/view_model/getCruiseTypes/get_cruise_types_bloc.dart';
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
