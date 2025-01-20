// import 'package:cruise_buddy/core/services/favourites/favourites_service.dart';
// import 'package:cruise_buddy/core/view_model/addItemToFavourites/add_item_to_favourites_bloc.dart';
// import 'package:cruise_buddy/core/view_model/getCruiseTypes/get_cruise_types_bloc.dart';
// import 'package:cruise_buddy/core/view_model/getFavouritesList/get_favourites_list_bloc.dart';
// import 'package:cruise_buddy/core/view_model/getLocationDetails/get_location_details_bloc.dart';
// import 'package:cruise_buddy/core/view_model/getSearchCruiseResults/get_seached_cruiseresults_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SearchResultsScreen extends StatefulWidget {
//   const SearchResultsScreen({super.key});

//   @override
//   State<SearchResultsScreen> createState() => _SearchResultsScreenState();
// }

// class _SearchResultsScreenState extends State<SearchResultsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       BlocProvider.of<GetSeachedCruiseresultsBloc>(context)
//           .add(GetSeachedCruiseresultsEvent.SeachedCruise());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AddItemToFavouritesBloc, AddItemToFavouritesState>(
//       listener: (context, state) {
//         state.map(
//           initial: (value) {
//             print(value);
//           },
//           loading: (value) {
//             print(value);
//           },
//           addedSuccess: (value) {
//             print(value);
//           },
//           addedFailure: (value) {
//             print(value);
//           },
//           noInternet: (value) {
//             print(value);
//           },
//         );
//       },
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   BlocProvider.of<AddItemToFavouritesBloc>(context).add(
//                     AddItemToFavouritesEvent.added(
//                       packageId: '44',
//                     ),
//                   );
//                 },
//                 child: Text("Call Api"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
