import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';

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

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({
    super.key,
  });

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  // List to hold the scale for each image container
  List<double> _scales = [];

  @override
  void initState() {
    super.initState();

    _scales = List.generate(exploreDestination.length, (index) => 1.0);
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
    onTapDown(index, TapDownDetails()); // Handle tap down with no details
    // You can reset the scale after a delay if needed
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        _scales[index] = 1.0; // Reset the scale after the animation duration
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
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
                child: Container(
                  color: const Color.fromARGB(0, 0, 0, 0),
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/image/onboarding_img/onboarding_one.png',
                          width: 200,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Luxury\nHouseboats",
                        style: TextStyles.ubuntu16blue86w500,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ExploreDestinationmodel {
  final String image;
  final String place;

  const ExploreDestinationmodel({
    required this.image,
    required this.place,
  });
}
