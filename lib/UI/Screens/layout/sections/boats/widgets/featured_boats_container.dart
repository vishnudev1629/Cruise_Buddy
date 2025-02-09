import 'dart:async';
import 'dart:convert';
import 'package:cruise_buddy/UI/Widgets/toast/custom_toast.dart';
import 'package:cruise_buddy/test_folder/gpay_test.dart';
import 'package:http/http.dart' as http;
import 'package:cruise_buddy/UI/Screens/layout/sections/Home/widgets/featured_shimmer_card.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:cruise_buddy/core/model/favourites_list_model/favourites_list_model.dart';
import 'package:cruise_buddy/core/routes/app_routes.dart';
import 'package:cruise_buddy/core/view_model/addItemToFavourites/add_item_to_favourites_bloc.dart';
import 'package:cruise_buddy/core/view_model/getFeaturedBoats/get_featured_boats_bloc.dart';
import 'package:cruise_buddy/core/view_model/removeItemFromFavourites/remove_item_favourites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PillWidget extends StatelessWidget {
  final String image;
  final String text;

  const PillWidget({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Color(0xFFE2E2E2),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 8),
          SvgPicture.asset(
            image,
            width: 14,
            height: 14,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}

class FeaturedBoatsSection extends StatefulWidget {
  const FeaturedBoatsSection({
    super.key,
  });

  @override
  State<FeaturedBoatsSection> createState() => _FeaturedBoatsSectionState();
}

class _FeaturedBoatsSectionState extends State<FeaturedBoatsSection> {
  List<double> _scales = [];
  List<bool> isFavoriteList = [];

  final StreamController<FavouritesListModel> _favoritesController =
      StreamController<FavouritesListModel>();

  Set<String> loadingFavorites = {};
  Map<String, String> favoritePackageMap = {};

  @override
  void initState() {
    super.initState();
    _scales = List.generate(10, (index) => 1.0);
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

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      final FavouritesListModel jsonResponse =
          FavouritesListModel.fromJson(decodedJson);
      _favoritesController.add(jsonResponse);

      favoritePackageMap = {
        for (var item in jsonResponse.data ?? [])
          if (item.package?.id != null && item.id != null)
            item.package!.id!.toString(): item.id!.toString()
      };
    } else {
      _favoritesController.addError("Failed to load favorites");
    }
  }

  void toggleFavorite(
      {String? packageId, bool? isFavorite, String? favouriteId}) {
    setState(() {
      loadingFavorites.add(packageId ?? "");
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

  void onTapDown(int index, TapDownDetails details) {
    setState(() {
      _scales[index] = 0.94;
    });
  }

  void onTapUp(int index, TapUpDetails details) {
    setState(() {
      _scales[index] = 1.0;
    });
  }

  void onTapCancel(int index) {
    setState(() {
      _scales[index] = 1.0;
    });
  }

  void handleTap(int index) {
    onTapDown(index, TapDownDetails());
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        _scales[index] = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FavouritesListModel>(
      stream: _favoritesController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return FeaturedBoatsShimmer(
            isLoading: true,
          );
        }
        if (snapshot.hasError) {
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
                  onPressed: () {},
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
        }

        if (snapshot.hasData) {
          favoritePackageMap = {
            for (var item in snapshot.data!.data ?? [])
              if (item.package?.id != null && item.id != null)
                item.package!.id!.toString(): item.id!.toString()
          };
        }

        return BlocListener<AddItemToFavouritesBloc, AddItemToFavouritesState>(
          listener: (context, state) {
            state.map(
              initial: (value) {},
              loading: (value) {},
              addedSuccess: (value) {
                CustomToast.itemAddedToast(context: context);
                setState(() {
                  loadingFavorites.remove(value
                      .postedfavouritemitemodel.favorite?.package?.id
                      .toString());
                });
                fetchFavorites();
              },
              addedFailure: (value) {
                setState(() {
                  loadingFavorites.clear();
                });
              },
              noInternet: (value) {
                setState(() {
                  loadingFavorites.clear();
                });
              },
            );
          },
          child:
              BlocListener<RemoveItemFavouritesBloc, RemoveItemFavouritesState>(
            listener: (context, state) {
              state.map(
                initial: (value) {},
                loading: (value) {},
                addedSuccess: (value) {
                  CustomToast.itemRemovedFromToast(context: context);
                  setState(() {
                    loadingFavorites.clear();
                  });
                  fetchFavorites();
                },
                addedFailure: (value) {
                  setState(() {
                    loadingFavorites.clear();
                  });
                },
                noInternet: (value) {
                  setState(() {
                    loadingFavorites.clear();
                  });
                },
              );
            },
            child: BlocBuilder<GetFeaturedBoatsBloc, GetFeaturedBoatsState>(
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
                    return value.featuredBoats.data?.isEmpty ?? true
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                Icon(
                                  Icons.directions_boat,
                                  size: 60,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "No Featured Boats Available",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 300,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.featuredBoats.data?.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final packageId = value
                                    .featuredBoats.data?[index].packages?[0].id
                                    ?.toString();

                                final isFavorite = packageId != null &&
                                    favoritePackageMap.containsKey(packageId);
                                final favouriteId = packageId != null
                                    ? favoritePackageMap[packageId]
                                    : null;
                                if (isFavoriteList.length <
                                    (value.featuredBoats.data?.length ?? 0)) {
                                  isFavoriteList = List.generate(
                                      value.featuredBoats.data!.length,
                                      (i) => false);
                                }

                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: index == 0 ? 30 : 10,
                                    right: (value.featuredBoats.data != null &&
                                            index ==
                                                value.featuredBoats.data!
                                                        .length -
                                                    1)
                                        ? 20
                                        : 0,
                                  ),
                                  child: GestureDetector(
                                    onTapDown: (details) =>
                                        onTapDown(index, details),
                                    onTapUp: (details) =>
                                        onTapUp(index, details),
                                    onTapCancel: () => onTapCancel(index),
                                    onTap: () => handleTap(index),
                                    child: AnimatedScale(
                                      scale: _scales[index],
                                      duration:
                                          const Duration(milliseconds: 150),
                                      curve: Curves.easeInOut,
                                      child: Container(
                                        width: 240,
                                        height: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          border: Border.all(
                                            color: const Color(0xFFE2E2E2),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 100,
                                                  child: Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  13),
                                                          topRight:
                                                              Radius.circular(
                                                                  13),
                                                        ),
                                                        child: Image.network(
                                                          "${value.featuredBoats.data?[index].cruisesImages?[0].cruiseImg}",
                                                          width:
                                                              double.infinity,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 60,
                                                        right: 8,
                                                        child: Container(
                                                          width: 68,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(
                                                                  width: 10),
                                                              const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                                size: 24,
                                                              ),
                                                              const Text("4.3"),
                                                              const SizedBox(
                                                                  width: 10),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  color: const Color.fromARGB(
                                                      0, 255, 214, 64),
                                                  height: 195,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            height: 10),
                                                        Row(
                                                          children: [
                                                            PillWidget(
                                                              image:
                                                                  'assets/icons/wifi.svg',
                                                              text: 'Wifi',
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            PillWidget(
                                                              image:
                                                                  'assets/icons/heater.svg',
                                                              text: 'Heater',
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          value
                                                                          .featuredBoats
                                                                          .data?[
                                                                              index]
                                                                          .name !=
                                                                      null &&
                                                                  value
                                                                          .featuredBoats
                                                                          .data![
                                                                              index]
                                                                          .name!
                                                                          .length >
                                                                      22
                                                              ? "${value.featuredBoats.data?[index].name!.substring(0, 22)}..."
                                                              : "${value.featuredBoats.data?[index].name}",
                                                          style: TextStyles
                                                              .ubuntu16black15w500,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/icons/mapIcon.svg",
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text("Kumarakom"),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "₹5000",
                                                              style: TextStyles
                                                                  .ubuntu18bluew700,
                                                            ),
                                                            Text(
                                                              "Price per night",
                                                              style: TextStyles
                                                                  .ubuntu6grey555,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: GestureDetector(
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: AnimatedSwitcher(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        transitionBuilder:
                                                            (child, animation) {
                                                          return ScaleTransition(
                                                              scale: animation,
                                                              child: child);
                                                        },
                                                        child: loadingFavorites
                                                                .contains(
                                                                    packageId)
                                                            ? const SizedBox(
                                                                height: 20,
                                                                width: 20,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      2,
                                                                ),
                                                              )
                                                            : Icon(
                                                                isFavorite
                                                                    ? Icons
                                                                        .favorite
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
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              right: 8,
                                              child: SizedBox(
                                                height: 45,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    AppRoutes
                                                        .navigateToBoatdetailScreen(
                                                            context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0XFF1F8386),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 16,
                                                      vertical: 12,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Book Now",
                                                    style: TextStyles
                                                        .ubuntu12whiteFFw400,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
                            onPressed: () {},
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
                            onPressed: () {},
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
            ),
          ),
        );
      },
    );
  }
}
