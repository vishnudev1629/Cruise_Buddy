import 'package:cruise_buddy/UI/Screens/layout/sections/Home/widgets/details_delegate.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:cruise_buddy/core/view_model/getLocationDetails/get_location_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';

class LocationSearchDelegate extends StatefulWidget {
  const LocationSearchDelegate({super.key});

  @override
  State<LocationSearchDelegate> createState() => _LocationSearchDelegateState();
}

class _LocationSearchDelegateState extends State<LocationSearchDelegate> {
  final List<String> locations = [
    "Kochifffffffffff",
    "Thrissur",
    "Trivandrum",
    "Calicut",
    "Kannur",
    "Alleppey",
    "Kottayam",
  ];

  String query = "";
  List<String> filteredLocations = [];
  Timer? _debounce;
  // Controller to manage the TextField input
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredLocations = locations;
    _controller.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        final currentQuery = _controller.text.trim();
        if (currentQuery.isNotEmpty) {
          BlocProvider.of<GetLocationDetailsBloc>(context).add(
            GetLocationDetailsEvent.getLocation(locationName: currentQuery),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
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
              onPressed: () {
                Navigator.of(context).pop();
              },
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
                      onChanged: (value) {
                        BlocProvider.of<GetLocationDetailsBloc>(context).add(
                            GetLocationDetailsEvent.getLocation(
                                locationName: _controller.text.toLowerCase()));
                      },
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
                  BlocBuilder<GetLocationDetailsBloc, GetLocationDetailsState>(
                    builder: (context, state) {
                      return state.map(
                        initial: (value) {
                          return SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: filteredLocations.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: SvgPicture.asset(
                                        'assets/icons/map.svg'),
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Selected: ${filteredLocations[index]}"),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ));
                        },
                        loading: (value) {
                          return CircularProgressIndicator();
                        },
                        getLocationDetails: (value) {
                          return SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: value.locationmodel.data?.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: SvgPicture.asset(
                                        'assets/icons/map.svg'),
                                    title: Text(
                                      value.locationmodel.data![index].name
                                          .toString(),
                                      style: TextStyles.ubuntu14black55w400,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        // Update based on the Bloc state data instead of always using filteredLocations

                                        _controller.text = value
                                            .locationmodel.data![index].name
                                            .toString();
                                        query = value
                                            .locationmodel.data![index].name
                                            .toString();

                                        // Reset filteredLocations only if necessary
                                        filteredLocations =
                                            locations; // Reset filtered locations
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Selected: ${_controller.text}"),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ));
                        },
                        getlocationsFailure: (value) {
                          return SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: filteredLocations.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: SvgPicture.asset(
                                        'assets/icons/map.svg'),
                                    title: Text(
                                      filteredLocations[index],
                                      style: TextStyles.ubuntu14black55w400,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _controller.text =
                                            filteredLocations[index];
                                        query = filteredLocations[index];
                                        filteredLocations = locations;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Selected: ${filteredLocations[index]}"),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ));
                        },
                        noInternet: (value) {
                          return SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: filteredLocations.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: SvgPicture.asset(
                                        'assets/icons/map.svg'),
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Selected: ${filteredLocations[index]}"),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ));
                        },
                      );
                    },
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
                  onPressed: () {
                    openDetailsDelegate(context);
                  },
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

  void openDetailsDelegate(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: const DetailsDelegate(),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
