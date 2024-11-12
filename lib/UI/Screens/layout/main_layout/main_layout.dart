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
      body: Column(
        children: [],
      ),
      bottomNavigationBar: SizedBox(
        height: 92.0,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 24.0, // Set a fixed width
                height: 24.0, // Set a fixed height
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
