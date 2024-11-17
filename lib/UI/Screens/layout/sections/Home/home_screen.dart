import 'package:cruise_buddy/UI/Screens/layout/sections/Home/widgets/categories_section.dart';
import 'package:cruise_buddy/UI/Screens/layout/sections/Home/widgets/explore_destination.dart';
import 'package:cruise_buddy/UI/Screens/layout/sections/Home/widgets/location_search_delgate.dart';
import 'package:cruise_buddy/UI/Screens/layout/sections/boats/widgets/featured_boats_container.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 230,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          'assets/home/promotionalBanner.svg',
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          left: 20,
                          top: 40,
                          child: SizedBox(
                            width: 220,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Hi",
                                      style: TextStyles.ubuntu32black15w700,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Rohan!",
                                      style: TextStyles.ubuntu32blue86w700,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Book your perfect boat adventure in just a few taps!",
                                  style: TextStyles.ubuntu14black55w400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20, // Padding on the left
                    right: 20, // Padding on the right
                    top: 180, // Position from the top
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double containerWidth = constraints.maxWidth -
                            40; // Total width minus padding on both sides
                        return GestureDetector(
                          onTap: () async {
                            openLocationSearchDelegate(context);
                          },
                          child: Container(
                            width: containerWidth,
                            height: 45, // Fixed height
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.2), // Shadow color with transparency
                                  spreadRadius: 0.4, // Spread the shadow evenly
                                  blurRadius: 4, // Softness of the shadow
                                  offset: Offset(0,
                                      0), // No offset for shadow on all sides
                                ),
                              ],
                              borderRadius: BorderRadius.circular(
                                  25), // Optional: Rounded corners
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                SvgPicture.asset('assets/icons/search.svg'),
                                SizedBox(width: 5),
                                Text(
                                  "Where dou you want to go?",
                                  style: TextStyles.ubuntu14black55w400,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: Text(
                "Featured Boats",
                style: TextStyles.ubuntu20black15w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0
                          ? 30
                          : 10, // Apply 30 for the first item, 10 for others
                    ),
                    child: FeaturedBoatContainer(),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: Text(
                "Categories",
                style: TextStyles.ubuntu20black15w700,
              ),
            ),
            SizedBox(height: 20),
            CategoriesSection(),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: Text(
                "Explore Destination",
                style: TextStyles.ubuntu20black15w700,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double gridWidth = constraints.maxWidth;
                  double itemWidth = (gridWidth - 15) / 2;
                  double itemHeight = itemWidth * 1.1;

                  return ExploreDestinationWidget(
                    itemWidth: itemWidth,
                    itemHeight: itemHeight,
                  );
                },
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  void openLocationSearchDelegate(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: const LocationSearchDelegate(),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
