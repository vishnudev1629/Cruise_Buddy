import 'dart:async';
import 'dart:convert';
import 'package:cruise_buddy/core/constants/functions/connection/connectivity_checker.dart';
import 'package:cruise_buddy/core/db/shared/shared_prefernce.dart';
import 'package:cruise_buddy/core/model/favourites_list_model/favourites_list_model.dart';
import 'package:cruise_buddy/core/model/location_model/location_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class FavouritesService {
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();

  final String url = 'https://khaki-cheetah-745520.hostingersite.com/api/v1';

  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'CRUISE_AUTH_KEY': '29B37-89DFC5E37A525891-FE788E23',
    // Bearer token will be added dynamically to the headers
  };

  Future<Either<String, FavouritesListModel>> getFavouriteDetails(
      {String? locationName}) async {
    try {
      final hasInternet = await _connectivityChecker.hasInternetAccess();
      if (!hasInternet) {
        print("No internet connection");
        return const Left('No internet connection');
      }

       final token = await GetSharedPreferences.getAccessToken();
     
      if (token == null) {
        print('No access token found.');
        return const Left('No access token found.');
      }

      // Add headers
      _headers['Authorization'] = 'Bearer $token';
      _headers['CRUISE_AUTH_KEY'] =
          '16|OJfQtxaw6r4MBeEQ4JLzIT1m4UClhdUhvK3zNVJ7e01d3d19';

      // Build URL with query parameter
      final uri = Uri.parse(
          '$url/favorite?include=user,package.cruise,package.cruise.cruiseType,package.cruise.ratings,package.itineraries,package.amenities,package.food,package.packageImages,package.bookingTypes');

      final response = await http.get(uri, headers: _headers).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('The request timed out.');
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final locationDetails = FavouritesListModel.fromJson(data);
        print(locationDetails.data?[0].package?.id);
        return Right(locationDetails);
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return Left('Failed to fetch location details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      return Left('Error: $e');
    }
  }
}
