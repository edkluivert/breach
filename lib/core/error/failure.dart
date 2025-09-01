import 'package:breach/core/core.dart';
import 'package:breach/core/error/error.dart';
import 'package:breach/core/error/error_model.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// Represents different types of failures in the app.
@freezed
class Failure with _$Failure {

  // Factory method to convert DioException to Failure
  factory Failure.fromDioError(DioException e) {
    try {
      final response = e.response;

      if (response != null && response.data != null) {
        final data = response.data;

        // Check if the response contains a 'message' field in a Map
        // if (data is Map<String, dynamic> && data.containsKey('message')) {
        //   final errorMessage = data['message'] as String;
        //   return Failure.serverError(message: errorMessage);
        // }
        if (data is Map<String, dynamic>) {
          final errorMessage = (data.containsKey('message') ?
          data['message'] as String : 'Unknown error');

          return Failure.serverError(message: errorMessage);
        }


        // Check for the ErrorModel in the response data
        if (data is ErrorModel) {
          final errorDetails = data.message;
          return Failure.serverError(message: errorDetails ?? 'An error occurred.');
        }

        if (data is String) {
          return Failure.serverError(message: data); // If raw string error
        }
      }

      // Handle network-related errors
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        return const Failure.noInternet();
      }

      // Fallback to a generic server error message
      return Failure.serverError(message: e.message ?? 'A network error occurred');
    } catch (_) {
      // In case something unexpected happens during error parsing.
      return const Failure.unknown();
    }
  }
  // Make the constructor private by adding an underscore
  const Failure._(); // Private constructor for the class to support freezed

  const factory Failure.serverError({required String message}) = ServerFailure;
  const factory Failure.noInternet() = NoInternetFailure;
  const factory Failure.unknown() = UnknownFailure;
  const factory Failure.app() = AppFailure;

  // Method to get just the error message (useful for logging)
  String get errorMessage => when(
    serverError: (message) => message,
    noInternet: () => 'No internet connection.',
    unknown: () => 'Unknown error occurred.',
    app: () => 'App error occurred.',
  );
}

Future<T> handleApiCall<T>(Future<T> Function() apiCall) async {
  try {
    return await apiCall();
  } catch (e) {
    if (e is DioException) {
      final failure = Failure.fromDioError(e);

      // Log the simplified message
      final simplifiedMessage = failure.errorMessage;
      AppLogger.d('DioError: $simplifiedMessage');

      // Throw a custom exception with the error message
      throw AppException(simplifiedMessage);
    } else {
      // Log the generic error
      AppLogger.d('Unknown error: $e');
      throw AppException('Something went wrong');
    }
  }


}



