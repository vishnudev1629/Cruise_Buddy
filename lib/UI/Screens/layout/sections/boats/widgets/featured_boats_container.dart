import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:cruise_buddy/core/view_model/getFeaturedBoats/get_featured_boats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class ExploreDestinationmodel {
  final String image;
  final String place;

  const ExploreDestinationmodel({
    required this.image,
    required this.place,
  });
}

List<ExploreDestinationmodel> exploreDestination = [
  const ExploreDestinationmodel(
    image: 'assets/image/onboarding_img/onboarding_one.png',
    place: 'Alleppey',
  ),
  const ExploreDestinationmodel(
    image: 'assets/image/onboarding_img/onboarding_one.png',
    place: 'Alleppey',
  ),
  const ExploreDestinationmodel(
    image: 'assets/image/onboarding_img/onboarding_one.png',
    place: 'Alleppey',
  ),
  const ExploreDestinationmodel(
    image: 'assets/image/onboarding_img/onboarding_one.png',
    place: 'Alleppey',
  ),
  const ExploreDestinationmodel(
    image: 'assets/image/onboarding_img/onboarding_one.png',
    place: 'Alleppey',
  ),
  const ExploreDestinationmodel(
    image: 'assets/image/onboarding_img/onboarding_one.png',
    place: 'Alleppey',
  ),
  const ExploreDestinationmodel(
    image: 'assets/image/onboarding_img/onboarding_one.png',
    place: 'Alleppey',
  ),
  const ExploreDestinationmodel(
    image: 'assets/image/onboarding_img/onboarding_one.png',
    place: 'Alleppey',
  ),
  const ExploreDestinationmodel(
    image: 'assets/image/onboarding_img/onboarding_one.png',
    place: 'Alleppey',
  ),
  const ExploreDestinationmodel(
    image: 'assets/image/onboarding_img/onboarding_one.png',
    place: 'Alleppey',
  ),
];

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

          SizedBox(width: 8), // Spacing between icon and text
          Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 14), // Text style
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

  @override
  void initState() {
    super.initState();
    _scales =
        List.generate(10, (index) => 1.0); // Adjust for the number of items
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      BlocProvider.of<GetFeaturedBoatsBloc>(context)
          .add(GetFeaturedBoatsEvent.getFeaturedBoats());
    });
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

  // Handle the tap without parameters for `onTap`
  void handleTap(int index) {
    onTapDown(index, TapDownDetails());
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        _scales[index] = 1.0; // Reset the scale after the animation duration
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFeaturedBoatsBloc, GetFeaturedBoatsState>(
      builder: (context, state) {
        return state.map(
          initial: (value) {
            return SizedBox(
              height: 300,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: exploreDestination.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 30 : 10,
                    ),
                    child: GestureDetector(
                      onTapDown: (details) => onTapDown(index, details),
                      onTapUp: (details) => onTapUp(index, details),
                      onTapCancel: () => onTapCancel(index),
                      onTap: () => handleTap(index),
                      child: AnimatedScale(
                        scale: _scales[index],
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeInOut,
                        child: Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 210, 209, 209),
                          highlightColor:
                              const Color.fromARGB(96, 242, 235, 235),
                          child: Container(
                            width: 240,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: const Color(0xFFE2E2E2),
                                width: 1.5,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(13),
                                              topRight: Radius.circular(13),
                                            ),
                                            child: Image.asset(
                                              "assets/image/onboarding_img/onboarding_one.png",
                                              width: double.infinity,
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
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 10),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 24,
                                                  ),
                                                  const Text("4.3"),
                                                  const SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color:
                                          const Color.fromARGB(0, 255, 214, 64),
                                      height: 195,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                PillWidget(
                                                  image:
                                                      'assets/icons/wifi.svg',
                                                  text: 'Wifi',
                                                ),
                                                const SizedBox(width: 5),
                                                PillWidget(
                                                  image:
                                                      'assets/icons/heater.svg',
                                                  text: 'Heater',
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Ashtamudi",
                                              style: TextStyles
                                                  .ubuntu16black15w500,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "₹5000",
                                                  style: TextStyles
                                                      .ubuntu18bluew700,
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Positioned items
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.favorite,
                                            color: Color(0XFF4FC2C5),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 35,
                                  right: 8,
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Your book now logic
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0XFF1F8386),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: (value) {
            return SizedBox(
              height: 300,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: exploreDestination.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 30 : 10,
                    ),
                    child: GestureDetector(
                      onTapDown: (details) => onTapDown(index, details),
                      onTapUp: (details) => onTapUp(index, details),
                      onTapCancel: () => onTapCancel(index),
                      onTap: () => handleTap(index),
                      child: AnimatedScale(
                        scale: _scales[index],
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeInOut,
                        child: Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 210, 209, 209),
                          highlightColor:
                              const Color.fromARGB(96, 242, 235, 235),
                          child: Container(
                            width: 240,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: const Color(0xFFE2E2E2),
                                width: 1.5,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(13),
                                              topRight: Radius.circular(13),
                                            ),
                                            child: Image.asset(
                                              "assets/image/onboarding_img/onboarding_one.png",
                                              width: double.infinity,
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
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 10),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 24,
                                                  ),
                                                  const Text("4.3"),
                                                  const SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color:
                                          const Color.fromARGB(0, 255, 214, 64),
                                      height: 195,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                PillWidget(
                                                  image:
                                                      'assets/icons/wifi.svg',
                                                  text: 'Wifi',
                                                ),
                                                const SizedBox(width: 5),
                                                PillWidget(
                                                  image:
                                                      'assets/icons/heater.svg',
                                                  text: 'Heater',
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Ashtamudi",
                                              style: TextStyles
                                                  .ubuntu16black15w500,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "₹5000",
                                                  style: TextStyles
                                                      .ubuntu18bluew700,
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Positioned items
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.favorite,
                                            color: Color(0XFF4FC2C5),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 35,
                                  right: 8,
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Your book now logic
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0XFF1F8386),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
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
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 30 : 10,
                          ),
                          child: GestureDetector(
                            onTapDown: (details) => onTapDown(index, details),
                            onTapUp: (details) => onTapUp(index, details),
                            onTapCancel: () => onTapCancel(index),
                            onTap: () => handleTap(index),
                            child: AnimatedScale(
                              scale: _scales[index],
                              duration: const Duration(milliseconds: 150),
                              curve: Curves.easeInOut,
                              child: Container(
                                width: 240,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(13),
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
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(13),
                                                  topRight: Radius.circular(13),
                                                ),
                                                child: Image.network(
                                                  "${value.featuredBoats.data?[index].cruisesImages?[0].cruiseImg}",
                                                  width: double.infinity,
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
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(width: 10),
                                                      const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 24,
                                                      ),
                                                      const Text("4.3"),
                                                      const SizedBox(width: 10),
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    PillWidget(
                                                      image:
                                                          'assets/icons/wifi.svg',
                                                      text: 'Wifi',
                                                    ),
                                                    const SizedBox(width: 5),
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
                                                                  .data?[index]
                                                                  .name !=
                                                              null &&
                                                          value
                                                                  .featuredBoats
                                                                  .data![index]
                                                                  .name!
                                                                  .length >
                                                              34
                                                      ? "${value.featuredBoats.data?[index].name!.substring(0, 34)}..."
                                                      : "${value.featuredBoats.data?[index].name}",
                                                  style: TextStyles
                                                      .ubuntu16black15w500,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "₹5000",
                                                      style: TextStyles
                                                          .ubuntu18bluew700,
                                                    ),
                                                    const Spacer(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Positioned items
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.favorite,
                                                color: Color(0XFF4FC2C5),
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 35,
                                      right: 8,
                                      child: SizedBox(
                                        height: 45,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Your book now logic
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0XFF1F8386),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                          ),
                                          child: Text(
                                            "Book Now",
                                            style:
                                                TextStyles.ubuntu12whiteFFw400,
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
            return CircularProgressIndicator();
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
  }
}
