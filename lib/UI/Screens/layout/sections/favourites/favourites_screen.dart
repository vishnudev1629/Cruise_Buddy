import 'package:cruise_buddy/UI/Screens/boat_detail/boat_detail_screen.dart';
import 'package:cruise_buddy/UI/Screens/layout/sections/boats/widgets/featured_boats_container.dart';
import 'package:cruise_buddy/core/view_model/getFavouritesList/get_favourites_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      BlocProvider.of<GetFavouritesListBloc>(context)
          .add(GetFavouritesListEvent.getFavouriteboats());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFavouritesListBloc, GetFavouritesListState>(
      builder: (context, state) {
        return state.map(initial: (value) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 100,
            ),
            child: Center(
              child: SpinKitWave(
                color: Colors.blue,
                size: 50.0,
              ),
            ),
          );
        }, loading: (value) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 100,
            ),
            child: Center(
              child: SpinKitWave(
                color: Colors.blue,
                size: 50.0,
              ),
            ),
          );
        }, getfavouritesBoats: (value) {
          if ((value.favourites?.data ?? []).isEmpty) {
            return Center(child: Text("No Favourites data found"));
          }

          return Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: value.favourites.data
                      ?.where((item) => item.package != null)
                      .length ??
                  0,
              itemBuilder: (context, index) {
                var favourite = value.favourites.data
                    ?.where((item) => item.package != null)
                    .toList()[index];

                return BuildFavouritesCard(
                  name: favourite?.package?.name?.toString() ?? 'N/A',
                );
              },
            ),
          );
        }, getfavouritesFailure: (value) {
          return ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              Text("Oops something went wrong"),
            ],
          );
        }, noInternet: (value) {
          return Text("No Internet");
        });
      },
    );
  }
}

class BuildFavouritesCard extends StatelessWidget {
  final String name;
  const BuildFavouritesCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Color(0xffFFFFFF),
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                  ),
                  child: Image.asset(
                    "assets/image/fav_screen_img2.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 160,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    //  onTap: () => _toggleFavorite(index),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.favorite,
                          color: const Color(0xff4FC2C5),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        Text("4.3"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PillWidget(
                        image: 'assets/icons/wifi.svg',
                        text: 'Wifi',
                      ),
                      const SizedBox(width: 5),
                      PillWidget(
                        image: 'assets/icons/heater.svg',
                        text: 'Heater',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${name}",
                    style: TextStyles.ubuntu16black15w500,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "₹5000",
                            style: TextStyles.ubuntu18bluew700,
                          ),
                          const Text(
                            "per night",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BoatDetailScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF1F8386),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          "Book Now",
                          style: TextStyles.ubuntu12whiteFFw400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
