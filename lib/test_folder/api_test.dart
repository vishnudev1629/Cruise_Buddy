import 'package:cruise_buddy/core/services/favourites/favourites_service.dart';
import 'package:cruise_buddy/core/view_model/addItemToFavourites/add_item_to_favourites_bloc.dart';
import 'package:cruise_buddy/core/view_model/getCruiseTypes/get_cruise_types_bloc.dart';
import 'package:cruise_buddy/core/view_model/getFavouritesList/get_favourites_list_bloc.dart';
import 'package:cruise_buddy/core/view_model/getLocationDetails/get_location_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiTest extends StatelessWidget {
  const ApiTest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddItemToFavouritesBloc, AddItemToFavouritesState>(
      listener: (context, state) {
        state.map(
          initial: (value) {
            print(value);
          },
          loading: (value) {
            print(value);
          },
          addedSuccess: (value) {
            print(value);
          },
          addedFailure: (value) {
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
                  BlocProvider.of<AddItemToFavouritesBloc>(context).add(
                    AddItemToFavouritesEvent.added(
                      packageId: '44',
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
