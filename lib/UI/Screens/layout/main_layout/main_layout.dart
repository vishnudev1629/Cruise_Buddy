import 'package:cruise_buddy/UI/Screens/layout/sections/Home/home_screen.dart';
import 'package:cruise_buddy/UI/Screens/layout/sections/account/account_screen.dart';
import 'package:cruise_buddy/UI/Screens/layout/sections/boats/boats_screen.dart';
import 'package:cruise_buddy/UI/Screens/layout/sections/favourites/favourites_screen.dart';
import 'package:cruise_buddy/core/constants/colors/app_colors.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  String getTitle(int index) {
    switch (index) {
      case 1:
        return 'My Booking';
      case 2:
        return 'Favorites';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _screens = [
    HomeScreen(),
    BoatsScreen(),
    FavouritesScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          SystemNavigator.pop();

          // Allow exit
        } else if (_selectedIndex == 1 ||
            _selectedIndex == 2 ||
            _selectedIndex == 3) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }

        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _selectedIndex != 0
            ? AppBar(
                forceMaterialTransparency: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      setState(() {
                        if (_selectedIndex == 1 ||
                            _selectedIndex == 2 ||
                            _selectedIndex == 3) {
                          _selectedIndex = 0;
                        } else if (_selectedIndex == 1) {}
                      });
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                title: Text(getTitle(_selectedIndex),
                    style: TextStyles.ubuntu32black15w700),
              )
            : null,
        body: _screens[_selectedIndex],
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
                label: 'Home',
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
                label: 'Boats',
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
                label: 'Favourites',
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
                label: 'Account',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: ColorConstants.darkblue86,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
