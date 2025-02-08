import 'package:cruise_buddy/UI/Screens/layout/sections/boats/widgets/featured_boats_container.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:cruise_buddy/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UiTest extends StatelessWidget {
  const UiTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 30 : 10,
                    right: 20,
                  ),
                  child: GestureDetector(
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
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(13),
                                        topRight: Radius.circular(13),
                                      ),
                                      child: Image.network(
                                        "https://khaki-cheetah-745520.hostingersite.com/storage/packages/images/FQkK19gU035oZw7T/8dc52bf09dfd64c8fd1955edadce9084.png",
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
                                color: const Color.fromARGB(0, 255, 214, 64),
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
                                      Text(
                                        "fsdfdsrgdfhf dfgregtr",
                                        style: TextStyles.ubuntu16black15w500,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/mapIcon.svg",
                                          ),
                                          Text("Kumarakom"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "₹5000",
                                            style: TextStyles.ubuntu18bluew700,
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
                                    borderRadius: BorderRadius.circular(25),
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
                                  AppRoutes.navigateToBoatdetailScreen(context);
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
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
    );
  }
}
