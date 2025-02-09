import 'dart:async';
import 'dart:convert';
import 'package:cruise_buddy/core/view_model/addItemToFavourites/add_item_to_favourites_bloc.dart';
import 'package:cruise_buddy/core/view_model/removeItemFromFavourites/remove_item_favourites_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:cruise_buddy/UI/Screens/layout/sections/boats/widgets/featured_boats_container.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:cruise_buddy/core/model/favourites_list_model/favourites_list_model.dart';
import 'package:cruise_buddy/core/routes/app_routes.dart';
import 'package:cruise_buddy/core/view_model/getFeaturedBoats/get_featured_boats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MargretTest extends StatefulWidget {
  const MargretTest({super.key});

  @override
  State<MargretTest> createState() => _MargretTestState();
}

class _MargretTestState extends State<MargretTest> {
 

  final StreamController<FavouritesListModel> _favoritesController =
      StreamController<FavouritesListModel>();

  Set<String> _loadingFavorites = {}; 
  Map<String, String> _favoritePackageMap = {}; 

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchFavorites();
      BlocProvider.of<GetFeaturedBoatsBloc>(context)
          .add(GetFeaturedBoatsEvent.getFeaturedBoats());
    });
    super.initState();
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

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      final FavouritesListModel jsonResponse =
          FavouritesListModel.fromJson(decodedJson);
      _favoritesController.add(jsonResponse);

      // Extract favorite package IDs and filter out null values
      _favoritePackageMap = {
        for (var item in jsonResponse.data ?? [])
          if (item.package?.id != null && item.id != null)
            item.package!.id!.toString(): item.id!.toString()
      };

      print('Favorite Map: $_favoritePackageMap');
    } else {
      _favoritesController.addError("Failed to load favorites");
    }
  }

  void toggleFavorite(
      {String? packageId, bool? isFavorite, String? favouriteId}) {
    setState(() {
      _loadingFavorites.add(packageId ?? ""); 
    });

    if (isFavorite ?? false) {
      _removeFromFavorites(favouriteId: favouriteId.toString());
    } else {
      BlocProvider.of<AddItemToFavouritesBloc>(context)
          .add(AddItemToFavouritesEvent.added(packageId: packageId ?? ""));
    }
  }

  void _removeFromFavorites({required String favouriteId}) {
    context
        .read<RemoveItemFavouritesBloc>()
        .add(RemoveItemFavouritesEvent.added(favouritesId: favouriteId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            StreamBuilder<FavouritesListModel>(
              stream: _favoritesController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching favorites"));
                }

           
                if (snapshot.hasData) {
                  _favoritePackageMap = {
                    for (var item in snapshot.data!.data ?? [])
                      if (item.package?.id != null && item.id != null)
                        item.package!.id!.toString(): item.id!.toString()
                  };
                }

                return BlocListener<AddItemToFavouritesBloc,
                    AddItemToFavouritesState>(
                  listener: (context, state) {
                    // );
                    state.map(
                      initial: (value) {},
                      loading: (value) {},
                      addedSuccess: (value) {
                        setState(() {
                          _loadingFavorites.remove(value
                              .postedfavouritemitemodel.favorite?.package?.id
                              .toString());
                        });
                        fetchFavorites(); // Refresh favorite list
                      },
                      addedFailure: (value) {
                        setState(() {
                          _loadingFavorites.clear();
                        });
                      },
                      noInternet: (value) {
                        setState(() {
                          _loadingFavorites.clear();
                        });
                      },
                    );
                  },
                  child: BlocListener<RemoveItemFavouritesBloc,
                      RemoveItemFavouritesState>(
                    listener: (context, state) {
                      state.map(
                        initial: (value) {},
                        loading: (value) {},
                        addedSuccess: (value) {
                          setState(() {
                            _loadingFavorites.clear();
                          });
                          fetchFavorites();
                        
                        },
                        addedFailure: (value) {
                          setState(() {
                            _loadingFavorites.clear();
                          });
                        },
                        noInternet: (value) {
                          setState(() {
                            _loadingFavorites.clear(); 
                          });
                        },
                      );
                    },
                    child: BlocBuilder<GetFeaturedBoatsBloc,
                        GetFeaturedBoatsState>(
                      builder: (context, state) {
                        return state.map(
                          initial: (value) => const Text("Initial"),
                          loading: (value) => const CircularProgressIndicator(),
                          getFeaturedBoats: (value) {
                            return SizedBox(
                              height: 300,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.featuredBoats.data?.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final packageId = value.featuredBoats
                                      .data?[index].packages?[0].id
                                      ?.toString();

                                  final isFavorite = packageId != null &&
                                      _favoritePackageMap
                                          .containsKey(packageId);
                                  final favouriteId = packageId != null
                                      ? _favoritePackageMap[packageId]
                                      : null;

                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: index == 0 ? 30 : 10,
                                      right:
                                          (value.featuredBoats.data != null &&
                                                  index ==
                                                      value.featuredBoats.data!
                                                              .length -
                                                          1)
                                              ? 20
                                              : 0,
                                    ),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (packageId != null) {
                                              toggleFavorite(
                                                packageId: packageId,
                                                isFavorite: isFavorite,
                                                favouriteId: favouriteId,
                                              );
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  transitionBuilder:
                                                      (child, animation) {
                                                    return ScaleTransition(
                                                        scale: animation,
                                                        child: child);
                                                  },
                                                  child: _loadingFavorites
                                                          .contains(packageId)
                                                      ? const SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                          ),
                                                        )
                                                      : Icon(
                                                          isFavorite
                                                              ? Icons.favorite
                                                              : Icons
                                                                  .favorite_border,
                                                          color: const Color(
                                                              0XFF4FC2C5),
                                                          size: 20,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text("Package id ${packageId}"),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          getFeaturedBoatsFailure: (value) =>
                              const Text("Error fetching boats"),
                          noInternet: (value) =>
                              const Text("No Internet Connection"),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
