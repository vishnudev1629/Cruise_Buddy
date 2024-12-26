import 'package:cruise_buddy/UI/Screens/layout/sections/boats/widgets/featured_boats_container.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoatsScreen extends StatefulWidget {
  const BoatsScreen({super.key});

  @override
  State<BoatsScreen> createState() => _BoatsScreenState();
}

class _BoatsScreenState extends State<BoatsScreen> {
  List<bool> isBookingList = [];
  List<double> _scales = [];

  @override
  void initState() {
    super.initState();
    int itemCount = 10;
    isBookingList = List.generate(itemCount, (index) => true);
    _scales = List.generate(itemCount, (index) => 1.0);
  }

  void _onTapDown(int index) {
    setState(() {
      _scales[index] = 0.94;
    });
  }

  void _onTapUp(int index) {
    setState(() {
      _scales[index] = 1.0;
    });
  }

  Widget _buildBookingCard(int index) {
    return GestureDetector(
      onTapDown: (_) => _onTapDown(index),
      onTapUp: (_) => _onTapUp(index),
      onTapCancel: () => _onTapUp(index),
      child: AnimatedScale(
        scale: _scales[index],
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: SizedBox(
          width: 240,
          height: 350,
          child: Card(
            color: Color(0XFFFFFFFF),
            margin: const EdgeInsets.only(right: 12),
            elevation: 1,
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
                            color: Color(0XFF1F8386),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
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
                      const SizedBox(height: 12),
                      Text(
                        "Kerala’s Heritage Haven – Traditional Kerala Décor",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SvgPicture.asset(
                              'assets/icons/location_icon (2).svg'),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Kumarakom',
                            style: TextStyles.ubuntu14black00w500,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                      color: Color(0XFF1F8386), width: 1),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                "Cancel Booking",
                                style: TextStyles.ubuntu12blue23w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
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
                                "View Details",
                                style: TextStyles.ubuntu12whiteFFw400,
                              ),
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Booking', style: TextStyles.ubuntu32black15w700),
              SizedBox(
                height: 15,
              ),
              Text('Upcoming Bookings', style: TextStyles.ubuntu20black15w600),
              SizedBox(
                height: 7,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    10,
                    (index) => _buildBookingCard(index),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('Upcoming Bookings', style: TextStyles.ubuntu20black15w600),
              SizedBox(
                height: 7,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    10,
                    (index) => _buildBookingCard(index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
