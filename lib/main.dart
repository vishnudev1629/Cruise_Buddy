import 'package:cruise_buddy/UI/Screens/Splash/splash_screen.dart';
import 'package:cruise_buddy/core/constants/functions/error/custom_error.dart';
import 'package:cruise_buddy/core/view_model/addItemToFavourites/add_item_to_favourites_bloc.dart';
import 'package:cruise_buddy/core/view_model/getCruiseTypes/get_cruise_types_bloc.dart';
import 'package:cruise_buddy/core/view_model/getFavouritesList/get_favourites_list_bloc.dart';
import 'package:cruise_buddy/core/view_model/getFeaturedBoats/get_featured_boats_bloc.dart';
import 'package:cruise_buddy/core/view_model/getLocationDetails/get_location_details_bloc.dart';
import 'package:cruise_buddy/core/view_model/getSearchCruiseResults/get_seached_cruiseresults_bloc.dart';
import 'package:cruise_buddy/core/view_model/getUserProfile/get_user_profile_bloc.dart';
import 'package:cruise_buddy/core/view_model/listCruiseonLocation/list_cruiseon_location_bloc.dart';
import 'package:cruise_buddy/core/view_model/login/login_bloc.dart';
import 'package:cruise_buddy/core/view_model/regsiter/register_bloc.dart';
import 'package:cruise_buddy/firebase_options.dart';
import 'package:cruise_buddy/test_folder/api_test.dart';
import 'package:cruise_buddy/test_folder/ui_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => GetUserProfileBloc(),
        ),
        BlocProvider(
          create: (context) => GetLocationDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => GetFeaturedBoatsBloc(),
        ),
        BlocProvider(
          create: (context) => GetCruiseTypesBloc(),
        ),
        BlocProvider(
          create: (context) => GetFavouritesListBloc(),
        ),
        BlocProvider(
          create: (context) => GetSeachedCruiseresultsBloc(),
        ),
        BlocProvider(
          create: (context) => AddItemToFavouritesBloc(),
        ),
        BlocProvider(
          create: (context) => ListCruiseonLocationBloc(),
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return CustomErrorWidget(errorDetails: errorDetails);
          };
          return child!;
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
          useMaterial3: true,
        ),
        home: SplashScreen(),
        //   home: SearchResultsScreen(),
      ),
    );
  }
}
