import 'package:cruise_buddy/UI/Screens/layout/main_layout/main_layout.dart';
import 'package:cruise_buddy/UI/Screens/layout/sections/Home/home_screen.dart';
import 'package:cruise_buddy/UI/Screens/Splash/splash_screen.dart';
import 'package:cruise_buddy/UI/Screens/layout/sections/Home/widgets/details_delegate.dart';
import 'package:cruise_buddy/UI/Screens/layout/sections/Home/widgets/location_search_delgate.dart';
import 'package:cruise_buddy/UI/Screens/search%20Results/screen/search_results_screen.dart';
import 'package:cruise_buddy/core/view_model/login/login_bloc.dart';
import 'package:cruise_buddy/macahan/ui_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const SearchResultsScreen(),
      ),
    );
  }
}



//------------