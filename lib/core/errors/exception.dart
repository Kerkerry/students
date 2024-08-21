import 'package:equatable/equatable.dart';

class APIException extends Equatable implements Exception {
  final int statusCode;
  final String message;

  const APIException({required this.statusCode, required this.message});
  @override
  List<Object?> get props => [statusCode, message];
}
