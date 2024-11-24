import 'dart:convert';
import 'package:cruise_buddy/core/constants/functions/connection/connectivity_checker.dart';
import 'package:cruise_buddy/core/model/cruise_type_model/cruise_type_model.dart';
import 'package:cruise_buddy/core/model/featured_boats_model/featured_boats_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class CruiseService {
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();

  final String url = 'https://khaki-cheetah-745520.hostingersite.com/api/v1';

  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'CRUISE_AUTH_KEY': '29B37-89DFC5E37A525891-FE788E23',
    // Bearer token will be added dynamically to the headers
  };

  Future<Either<String, CruiseTypeModel>> getCruiseTypes() async {
    try {
      final hasInternet = await _connectivityChecker.hasInternetAccess();
      if (!hasInternet) {
        print("No internet");
        return const Left('No internet');
      }

      // Adding the Authorization Bearer token to the headers dynamically
      _headers['Authorization'] =
          'Bearer 28|IhezHX5SbP9QfVBEqvHbg4LRdeq0wPxCf33uXLad7c50bf88';

      final response = await http.get(
        Uri.parse('$url/cruise-type'),
        headers: _headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        final cruisetypes = CruiseTypeModel.fromJson(data);
        print(data);
        return Right(cruisetypes);
      } else {
        print('Request failed: ${response.body.toLowerCase()}');
        return Left('Failed to get cruise type: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return Left('Error: $e'); // Handling other errors
    }
  }

 Future<Either<String, FeaturedBoatsModel>> getFeaturedBoats() async {
    try {
      final hasInternet = await _connectivityChecker.hasInternetAccess();
      if (!hasInternet) {
        print("No internet");
        return const Left('No internet');
      }

      // Adding the Authorization Bearer token to the headers dynamically
      _headers['Authorization'] =
          'Bearer 28|IhezHX5SbP9QfVBEqvHbg4LRdeq0wPxCf33uXLad7c50bf88';

      final response = await http.get(
        Uri.parse('$url/featured/cruise?include=cruisesImages,packages.bookingTypes&limit=2'),
        headers: _headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        final locationdetails = FeaturedBoatsModel.fromJson(data);
        print(data);
        return Right(locationdetails);
      } else {
        print('Request failed: ${response.body.toLowerCase()}');
        return Left('Failed to get cruise type: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return Left('Error: $e'); // Handling other errors
    }
  }



}
