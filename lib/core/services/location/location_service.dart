import 'dart:convert';
import 'package:cruise_buddy/core/constants/functions/connection/connectivity_checker.dart';
import 'package:cruise_buddy/core/db/shared/shared_prefernce.dart';
import 'package:cruise_buddy/core/model/location_model/location_model.dart';
import 'package:cruise_buddy/core/model/user_profile_model/user_profile_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class LocationService {
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();

  final String url = 'https://khaki-cheetah-745520.hostingersite.com/api/v1';

  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'CRUISE_AUTH_KEY': '29B37-89DFC5E37A525891-FE788E23',
    // Bearer token will be added dynamically to the headers
  };

  Future<Either<String, LocationModel>> getLocationDetails() async {
    try {
      final hasInternet = await _connectivityChecker.hasInternetAccess();
      if (!hasInternet) {
        print("No internet");
        return const Left('No internet');
      }

      // Retrieve the Bearer token from shared preferences
      final token = await GetSharedPreferences.getAccessToken();

      if (token == null) {
        print('No access token found.');
        return const Left('No access token found.');
      }

      // Add the Authorization Bearer token to the headers dynamically
      _headers['Authorization'] = 'Bearer $token';

      final response = await http.get(
        Uri.parse('$url/location'),
        headers: _headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        final locationdetails = LocationModel.fromJson(data);
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
