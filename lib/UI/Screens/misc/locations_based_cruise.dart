import 'package:cruise_buddy/UI/Screens/layout/sections/boats/widgets/featured_boats_container.dart';
import 'package:cruise_buddy/UI/Screens/layout/sections/favourites/favourites_screen.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:cruise_buddy/core/view_model/listCruiseonLocation/list_cruiseon_location_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationsBasedCruiseScreen extends StatefulWidget {
  final String location;
  const LocationsBasedCruiseScreen({
    super.key,
    required this.location,
  });

  @override
  State<LocationsBasedCruiseScreen> createState() =>
      _LocationsBasedCruiseScreenState();
}

class _LocationsBasedCruiseScreenState
    extends State<LocationsBasedCruiseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      BlocProvider.of<ListCruiseonLocationBloc>(context)
          .add(ListCruiseonLocationEvent.getCruise(location: widget.location));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListCruiseonLocationBloc, ListCruiseonLocationState>(
      listener: (context, state) {
        state.map(
          initial: (value) {
            print(value);
          },
          loading: (value) {
            print(value);
          },
          getcruiseuccess: (value) {
            print(value);
          },
          getcruiseFailure: (value) {
            print(value);
          },
          noInternet: (value) {
            print(value);
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios)),
          title:
              Text('${widget.location}', style: TextStyles.ubuntu32black15w700),
        ),
        body: BlocBuilder<ListCruiseonLocationBloc, ListCruiseonLocationState>(
          builder: (context, state) {
            return state.map(
              initial: (value) {
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
              },
              loading: (value) {
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
              },
              getcruiseuccess: (value) {
                final cruiseData = value.cruisemodel.data;

                if (cruiseData == null || cruiseData.isEmpty) {
                  // When there's no data, display a "No data available" message
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              'assets/icons/not_available_404.svg'),
                          Text(
                            "No Cruise Available",
                            style: TextStyles.ubuntu18bluew700,
                          ),
                          Center(
                            child: Text(
                              "It looks like no cruises are available in the ${widget.location} location.",
                              textAlign: TextAlign
                                  .center, // Ensures multi-line text is centered
                              style: TextStyles
                                  .ubuntu14black55w400, // Optional: Adjust font size or style
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: value.cruisemodel.data?.length,
                    itemBuilder: (context, index) {
                      return BuildFavouritesCard(
                        name: value.cruisemodel.data![index].name.toString(),
                      );
                    },
                  ),
                );
              },
              getcruiseFailure: (value) {
                return Text("Oops something went wrong");
              },
              noInternet: (value) {
                return Text("No Internet");
              },
            );
          },
        ),
      ),
    );
  }
}

class BuildLocationsCard extends StatelessWidget {
  final String name;
  const BuildLocationsCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
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
                    height: 140,
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
                        onPressed: () {},
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
