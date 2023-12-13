import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'exceptions.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class AuthFailure extends Failure {
  AuthFailure(super.message);

  factory AuthFailure.fromFirebaseAuthException(
      FirebaseAuthException exception) {
    print('auth exception code : ${exception.code} ${exception.message}');
    switch (exception.code) {
      case 'email-already-in-use':
        return AuthFailure(
            'The email address is already in use by another account.');
      case 'invalid-email':
        return AuthFailure('The email address is not valid.');
      case 'weak-password':
        return AuthFailure('The password is too weak.');
      case 'requires-recent-login':
        return AuthFailure(
            'This operation is sensitive and requires recent authentication. Log in again before retrying this request.');
      case 'operation-not-allowed':
        return AuthFailure('This operation is not allowed right now. Try again later');
      case 'network-request-failed':
        return AuthFailure('No Internet Connection');
      case 'INVALID_LOGIN_CREDENTIALS':
      case 'invalid-credential':
        return AuthFailure(
            "The data you provided is incorrect. Please make sure you've entered the right information and try again. ");
      case 'too-many-requests':
        return AuthFailure(
            "We have blocked all requests from this device due to unusual activity. Try again later.");
      default:
        return AuthFailure('An error occurred, please try again.');
    }
  }

  factory AuthFailure.fromNotVerifiedException() {
    return AuthFailure(
        'This email is not Verified, you have to verify your email');
  }
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromHttpException(BadResponseException httpException) {
    final statusCode = httpException.statusCode;
    final response = httpException.message;

    if (statusCode == 404) {
      return ServerFailure('Your request was not found, please try later');
    } else if (statusCode == 500) {
      return ServerFailure('There is a temporary problem, please try later');
    } else if (statusCode >= 400) {
      if (response.isNotEmpty) {
        /*
          WHILE DEALING WITH FIREBASE
          {"error" : "The error"},
          OR
          the message directly like
          "append .json to your request URI to use the REST API."
         */
        String responseMessage;
        try {
          responseMessage = jsonDecode(response)['error'];
        } catch (e) {
          responseMessage = response;
        }
        return ServerFailure(responseMessage);
      } else {
        return ServerFailure(
            'Unknown server error with status code: $statusCode');
      }
    } else {
      return ServerFailure('Oops there was an error, please try again');
    }
  }

  factory ServerFailure.fromSocketException() {
    return ServerFailure('No Internet Connection');
  }
}
