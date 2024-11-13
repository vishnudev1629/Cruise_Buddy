import 'package:cruise_buddy/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity, // Set the desired width
              height: 200, // Set the desired height
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/home/promotionalBanner.svg',
                    fit: BoxFit
                        .cover, // Ensures the SVG covers the available space
                  ),
                  Positioned(
                    left: 20, // Adjust to position horizontally
                    top: 50, // Adjust to position vertically
                    child: SizedBox(
                      width: 220,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi Rohan!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:
                                  Colors.black, // Adjust color for visibility
                            ),
                          ),
                          Text(
                            "Book your perfect boat adventure in just a few taps!",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Colors.black, // Adjust color for visibility
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 82.0,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 24.0,
                height: 24.0,
                child: _selectedIndex == 0
                    ? SvgPicture.asset(
                        'assets/bottomNav/home.svg',
                        colorFilter: const ColorFilter.mode(
                          ColorConstants.darkblue86,
                          BlendMode.srcIn,
                        ),
                      )
                    : SvgPicture.asset(
                        'assets/bottomNav/home.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 24.0,
                height: 24.0,
                child: _selectedIndex == 1
                    ? SvgPicture.asset(
                        'assets/bottomNav/boats.svg',
                        colorFilter: const ColorFilter.mode(
                          ColorConstants.darkblue86,
                          BlendMode.srcIn,
                        ),
                      )
                    : SvgPicture.asset(
                        'assets/bottomNav/boats.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 24.0,
                height: 24.0,
                child: _selectedIndex == 2
                    ? SvgPicture.asset(
                        'assets/bottomNav/favourites.svg',
                        colorFilter: const ColorFilter.mode(
                          ColorConstants.darkblue86,
                          BlendMode.srcIn,
                        ),
                      )
                    : SvgPicture.asset(
                        'assets/bottomNav/favourites.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
              ),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 24.0,
                height: 24.0,
                child: _selectedIndex == 3
                    ? SvgPicture.asset(
                        'assets/bottomNav/profile.svg',
                        colorFilter: const ColorFilter.mode(
                          ColorConstants.darkblue86,
                          BlendMode.srcIn,
                        ),
                      )
                    : SvgPicture.asset(
                        'assets/bottomNav/profile.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: ColorConstants.darkblue86,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
