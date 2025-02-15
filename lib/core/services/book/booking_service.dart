import 'dart:async';
import 'dart:convert';
import 'package:cruise_buddy/core/constants/functions/connection/connectivity_checker.dart';
import 'package:cruise_buddy/core/db/shared/shared_prefernce.dart';
import 'package:cruise_buddy/core/model/booking_response_model/booking_response_model.dart';
import 'package:cruise_buddy/core/model/favourites_list_model/favourites_list_model.dart';
import 'package:cruise_buddy/core/model/posted_favouritem_item_model/posted_favouritem_item_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class BookingService {
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();

  final String url = 'https://khaki-cheetah-745520.hostingersite.com/api/v1';

  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'CRUISE_AUTH_KEY': '29B37-89DFC5E37A525891-FE788E23',
  };

  Future<Either<String, BookingResponseModel>> addItemToBookeditem({
    required String packageId,
    required String bookingTypeId,
    required String vegCount,
    required String nonVegCount,
    required String jainVegCount,
    required String customerNote,
    required String startDate,
    required String totalAmount,
  }) async {
    try {
      final hasInternet = await _connectivityChecker.hasInternetAccess();

      if (!hasInternet) {
        print("No internet");
        return const Left('No internet');
      }

      final token = await GetSharedPreferences.getAccessToken();
      if (token == null) {
        print('No access token found.');
        return const Left('No access token found.');
      }

      // Add headers
      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'CRUISE_AUTH_KEY': '29B37-89DFC5E37A525891-FE788E23',
      };

      // Build URL
      final uri = Uri.parse('$url/booking');

      // Create request body
      final body = {
        'packageId': "53",
        'bookingTypeId': "1",
        'vegCount': "1",
        'nonVegCount': "15",
        'jainVegCount': "10",
        'customerNote': "This is a test booking",
        'startDate': startDate,
        'totalAmount': "50",
      };

      // Make POST request
      final response = await http
          .post(
        uri,
        headers: headers,
        body: body,
      )
          .timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('The request timed out.');
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final bookingDetails = BookingResponseModel.fromJson(data);
        print('Response Data: ${data}');
        return Right(bookingDetails);
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return Left('Failed to fetch booking details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      return Left('Error: $e');
    }
  }
}
