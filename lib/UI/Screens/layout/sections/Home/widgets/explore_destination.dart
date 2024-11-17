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

class ExploreDestinationWidget extends StatefulWidget {
  const ExploreDestinationWidget({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
  });

  final double itemWidth;
  final double itemHeight;

  @override
  State<ExploreDestinationWidget> createState() =>
      _ExploreDestinationWidgetState();
}

class _ExploreDestinationWidgetState extends State<ExploreDestinationWidget> {
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
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: exploreDestination.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: widget.itemWidth / widget.itemHeight,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTapDown: (details) => onTapDown(index, details),
          onTapUp: (details) => onTapUp(index, details),
          onTap: () => handleTap(index),
          onTapCancel: () => onTapCancel(index),
          child: AnimatedScale(
            scale: _scales[index],
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/image/onboarding_img/onboarding_one.png',
                    fit: BoxFit.cover,
                    width: widget.itemWidth,
                    height: widget.itemHeight,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Text(
                    "Alleppey",
                    style: TextStyles.ubuntu16whiteE2w2500,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
