import 'dart:convert';
import 'package:cruise_buddy/core/constants/functions/connection/connectivity_checker.dart';
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

  Future<Either<String, Map<String, dynamic>>> getCruiseType({
    required String bearerToken,
  }) async {
    try {
      final hasInternet = await _connectivityChecker.hasInternetAccess();
      if (!hasInternet) {
        print("No internet");
        return const Left('No internet connection');
      }

      // Adding the Authorization Bearer token to the headers dynamically
      _headers['Authorization'] = 'Bearer $bearerToken';

      final response = await http.get(
        Uri.parse('$url/cruise-type'),
        headers: _headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return Right(data); // Return the response body as a map if successful
      } else {
        print('Request failed: ${response.body.toLowerCase()}');
        return Left('Failed to get cruise type: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error: $e'); // Handling other errors
    }
  }
}
