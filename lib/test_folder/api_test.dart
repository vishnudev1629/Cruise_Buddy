import 'package:cruise_buddy/UI/Screens/search%20Results/widgets/search_results_container.dart';
import 'package:cruise_buddy/core/view_model/getSearchCruiseResults/get_seached_cruiseresults_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      BlocProvider.of<GetSeachedCruiseresultsBloc>(context)
          .add(GetSeachedCruiseresultsEvent.SeachedCruise());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<GetSeachedCruiseresultsBloc,
                GetSeachedCruiseresultsState>(
              builder: (context, state) {
                return state.map(
                  initial: (value) {
                    return Text("initial");
                  },
                  loading: (value) {
                    return Text("loading");
                  },
                  getuseruccess: (value) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 35,
                        ),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.packagesearchresults.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: SearchResultsContainer(
                                cruisename:
                                    value.packagesearchresults.data[index].name,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  getuserFailure: (value) {
                    return Text("getuserFailure");
                  },
                  noInternet: (value) {
                    return Text("noInternet");
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
