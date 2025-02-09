import 'package:cruise_buddy/UI/Screens/layout/sections/Home/widgets/featured_shimmer_card.dart';
import 'package:cruise_buddy/core/model/favourites_list_model/favourites_list_model.dart';
import 'package:cruise_buddy/core/view_model/addItemToFavourites/add_item_to_favourites_bloc.dart';
import 'package:cruise_buddy/core/view_model/getFeaturedBoats/get_featured_boats_bloc.dart';
import 'package:cruise_buddy/core/view_model/removeItemFromFavourites/remove_item_favourites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class MargretTest extends StatefulWidget {
  const MargretTest({super.key});

  @override
  State<MargretTest> createState() => _MargretTestState();
}

class _MargretTestState extends State<MargretTest> {
  final StreamController<FavouritesListModel> _favoritesController =
      StreamController<FavouritesListModel>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchFavorites();
      BlocProvider.of<GetFeaturedBoatsBloc>(context)
          .add(GetFeaturedBoatsEvent.getFeaturedBoats());
    });
  }

  Future<void> fetchFavorites() async {
    final response = await http.get(
      Uri.parse(
          'https://khaki-cheetah-745520.hostingersite.com/api/v1/favorite?include=package.cruise'),
      headers: {
        'Accept': 'application/json',
        'CRUISE_AUTH_KEY': '29B37-89DFC5E37A525891-FE788E23',
        'Authorization':
            'Bearer 108|hnbzjAuwTKEAScZyLySd6zIZfTdwilLRBJBtgUa72d62549f',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);

      // Ensure FavouritesListModel has a fromJson method
      final FavouritesListModel jsonResponse =
          FavouritesListModel.fromJson(decodedJson);
      print('dfdgdfgffdg ${jsonResponse.data?.length}');
      _favoritesController.add(jsonResponse);
    } else {
      _favoritesController.addError("Failed to load favorites");
    }
  }

  @override
  void dispose() {
    _favoritesController.close();
    super.dispose();
  }

  List<bool> isFavoriteList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FavouritesListModel>(
        stream: _favoritesController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching favorites"));
          }

          return BlocBuilder<GetFeaturedBoatsBloc, GetFeaturedBoatsState>(
            builder: (context, state) {
              return state.map(
                initial: (value) {
                  return FeaturedBoatsShimmer(
                    isLoading: true,
                  );
                },
                loading: (value) {
                  return FeaturedBoatsShimmer(
                    isLoading: true,
                  );
                },
                getFeaturedBoats: (value) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (isFavoriteList.length <
                                (value.featuredBoats.data?.length ??
                                    0)) {
                              isFavoriteList = List.generate(
                                  value.featuredBoats.data!.length,
                                  (i) => false);
                            }

                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 30 : 10,
                                right: 20,
                              ),
                              child: GestureDetector(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(13),
                                    border: Border.all(
                                      color: const Color(0xFFE2E2E2),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // setState(() {
                                      //   isFavoriteList[index] =
                                      //       isFavoriteList[index];
                                      // });
                                      // if (isFavoriteList[index]) {
                                      //   // Call AddItemToFavourites if it's not in favorites
                                      //   BlocProvider.of<
                                      //               AddItemToFavouritesBloc>(
                                      //           context)
                                      //       .add(
                                      //     AddItemToFavouritesEvent
                                      //         .added(
                                      //       packageId:
                                      //           '${value.featuredBoats.data?[index].packages?[0].id}',
                                      //     ),
                                      //   );
                                      // } else {
                                      //   // Ensure data is not null
                                      //   final dataList =
                                      //       snapshot.data?.data ?? [];

                                      //   // Find the index based on the list length
                                      //   int itemIndex =
                                      //       dataList.indexWhere(
                                      //     (item) =>
                                      //         item.id.toString() ==
                                      //         snapshot
                                      //             .data?.data?[index].id
                                      //             .toString(),
                                      //   );

                                      //   // Pass it to the Bloc event
                                      //   BlocProvider.of<
                                      //               RemoveItemFavouritesBloc>(
                                      //           context)
                                      //       .add(
                                      //     RemoveItemFavouritesEvent
                                      //         .added(
                                      //       favouritesId:
                                      //           '${snapshot.data?.data?[index].id.toString()}',
                                      //     ),
                                      //   );
                                      // }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.all(5.0),
                                          child: AnimatedSwitcher(
                                            duration: Duration(
                                                milliseconds: 300),
                                            transitionBuilder:
                                                (child, animation) {
                                              return ScaleTransition(
                                                  scale: animation,
                                                  child: child);
                                            },
                                            child: Icon(
                                              isFavoriteList[index]
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border,
                                              key: ValueKey<bool>(
                                                  isFavoriteList[
                                                      index]),
                                              color: isFavoriteList[
                                                      index]
                                                  ? Color(0XFF4FC2C5)
                                                  : Color(0XFF4FC2C5),
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                            return Text("data");
                          },
                        ),
                      ),
                    ],
                  );
                },
                getFeaturedBoatsFailure: (value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off,
                          color: Colors.grey,
                          size: 80,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No Internet Connection",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Please check your network and try again.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Trigger retry logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            "Retry",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                noInternet: (value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off,
                          color: Colors.grey,
                          size: 80,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No Internet Connection",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Please check your network and try again.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Trigger retry logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            "Retry",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
