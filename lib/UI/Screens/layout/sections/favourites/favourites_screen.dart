import 'dart:async';
import 'package:cruise_buddy/UI/Screens/layout/sections/boats/widgets/featured_boats_container.dart';
import 'package:flutter/material.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<bool> isFavoriteList = [];
  List<double> _scales = [];
  bool showUndoSection = false;
  int lastRemovedIndex = -1;

  @override
  void initState() {
    super.initState();
    int itemCount = 10;
    isFavoriteList = List.generate(itemCount, (index) => true);
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

  void _toggleFavorite(int index) {
    setState(() {
      isFavoriteList[index] = false;
      lastRemovedIndex = index;
      showUndoSection = true;

      Timer(const Duration(seconds: 2), () {
        if (mounted && lastRemovedIndex == index) {
          setState(() {
            showUndoSection = false;
          });
        }
      });
    });
  }

  void _undoLastRemoval() {
    if (lastRemovedIndex != -1) {
      setState(() {
        isFavoriteList[lastRemovedIndex] = true;
        showUndoSection = false;
      });
    }
  }

  Widget _buildFavoriteCard(int index) {
    return GestureDetector(
      onTapDown: (_) => _onTapDown(index),
      onTapUp: (_) => _onTapUp(index),
      onTapCancel: () => _onTapUp(index),
      onTap: () {
        _onTapDown(index);
        Future.delayed(const Duration(milliseconds: 150), () {
          _onTapUp(index);
        });
      },
      child: AnimatedScale(
        scale: _scales[index],
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
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
                      onTap: () => _toggleFavorite(index),
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
                            color: isFavoriteList[index]
                                ? const Color(0xff4FC2C5)
                                : Colors.grey.shade300,
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
                    const SizedBox(height: 8),
                    Text(
                      "Kerala’s Heritage Haven – Traditional Kerala Décor",
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Text("Favorites", style: TextStyles.ubuntu16black23w700),
            ),
            SizedBox(height: 8),
            if (showUndoSection)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                color: Colors.grey.shade100,
                child: ListTile(
                  title: const Text(
                    "Item removed",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: TextButton(
                    onPressed: _undoLastRemoval,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "UNDO",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return isFavoriteList[index]
                      ? _buildFavoriteCard(index)
                      : const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
