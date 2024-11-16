import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationSearchDelegate extends StatefulWidget {
  const LocationSearchDelegate({super.key});

  @override
  State<LocationSearchDelegate> createState() => _LocationSearchDelegateState();
}

class _LocationSearchDelegateState extends State<LocationSearchDelegate> {
  final List<String> locations = [
    "Kochi",
    "Thrissur",
    "Trivandrum",
    "Calicut",
    "Kannur",
    "Alleppey",
    "Kottayam",
  ];

  String query = "";
  List<String> filteredLocations = [];

  // Controller to manage the TextField input
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredLocations = locations;
    _controller.addListener(() {
      updateSearchQuery(_controller.text);
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      query = newQuery;
      filteredLocations = locations
          .where((location) =>
              location.toLowerCase().contains(newQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios_new_sharp),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                    child: TextField(
                      style: TextStyles.ubuntu14black55w400,
                      controller: _controller, // Attach the controller
                      onChanged: updateSearchQuery,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: SvgPicture.asset(
                            'assets/icons/search.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        suffixIcon: query.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  _controller.clear(); // Clear the text field
                                  updateSearchQuery('');
                                },
                              )
                            : null,
                        hintText: "Search location...",
                        hintStyle: TextStyles.ubuntu14black55w400,
                        labelStyle: TextStyles.ubuntu14black55w400,
                        prefixStyle: TextStyles.ubuntu14black55w400,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/location.svg'),
                        const SizedBox(width: 10),
                        Text(
                          "Choose Your Current Location",
                          style: TextStyles.ubuntu14black55w400,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 5),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    child: filteredLocations.isNotEmpty
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: filteredLocations.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading:
                                    SvgPicture.asset('assets/icons/map.svg'),
                                title: Text(
                                  filteredLocations[index],
                                  style: TextStyles.ubuntu14black55w400,
                                ),
                                onTap: () {
                                  setState(() {
                                    _controller.text = filteredLocations[
                                        index]; // Update text field with selected location
                                    query = filteredLocations[
                                        index]; // Update query for filtering
                                    filteredLocations =
                                        locations; // Reset filtered locations
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Selected: ${filteredLocations[index]}"),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              "No locations found",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Color(0XFF1F8386),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Continue",
                    style: TextStyles.ubuntu16whiteFFw500,
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
