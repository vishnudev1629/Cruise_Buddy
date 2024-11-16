import 'dart:convert';
import 'package:cruise_buddy/core/constants/functions/connection/connectivity_checker.dart';
import 'package:cruise_buddy/core/model/login_model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class ApiServices {
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();

  final String _url =
      'https://khaki-cheetah-745520.hostingersite.com/api/v1/login';
  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'CRUISE_AUTH_KEY': '29B37-89DFC5E37A525891-FE788E23',
    'Cookie':
        'XSRF-TOKEN=eyJpdiI6IktBbkpHQ051U2pnd1drYy90MVA1anc9PSIsInZhbHVlIjoieEFMbHVzMzMzSTluSnZCSnJYa0RXUXQ1UURqK1huY1RHdFZvZjFWR3NHWWphd0FQZ05iSmNqa0NDUTB4K1R4Q0RjclVVS1VRbStYMjRYdEEvSUgwS3VQWHNCaVJ5ZzFwelVpM2I4NnRvYWs5WDFYblV5TkpwQ3Q1bEo4b3I0U0EiLCJtYWMiOiI4ZWQ2OWQ4ODQwNTVlZTgzZmM5MDIwYjQ4NzY1MTk1NDdhMDdkMjIyMTZjNjA2MTRlYjAwZDJmNWQ0ZGRlZjYyIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IkUzRE5yWUhmaWtxeTV4b1hFZXVjdVE9PSIsInZhbHVlIjoiL0h0NjY4SndVSlU2WHdCZHlKQUNaUGFVTGZ4Q3U2UXZ3YUdjUmh2RmdkcVVUVm92QzFsUUFjUWdrNkNXNENEb0Z3d3NlbDVzQTFWSEUzMW5QbzdudjA4NWpMU0dNT0wzYWVyZmVndENST1I5NG5tTmlhUVFoNmhjZGxhaW5KcG8iLCJtYWMiOiJjYWY0ZTRlNjY2ZTFjYzVjYThmMjVmNTIwZDhlMDQxM2QzYWVlYWY5N2UxNzdhYzk3ODU3ZWI3MzQyNmNhYmRjIiwidGFnIjoiIn0%3D',
  };

  Future<Either<String, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final hasInternet = await _connectivityChecker.hasInternetAccess();
      if (!hasInternet) {
        print("No internet");
        return const Left('No internet connection');
      }
      final response = await http.post(
        Uri.parse(_url),
        headers: _headers,
        body: {
          'email': 'test@example.com',
          'password': 'test@example.com',
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(response.body);

        final loginModel = LoginModel.fromJson(data);
        print(loginModel.user?.name);
        return Right(loginModel);
      } else {
        print('data failed ${response.body.toLowerCase()}');
        return Left('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
