import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String message;
  final Map<String, dynamic> data;
  final bool error;
  AuthModel({
    required this.message,
    required this.data,
    required this.error,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      message: json['message'],
      data: Map<String, dynamic>.from(json['data']),
      error: json['error'],
    );
  }

  @override
  List<Object?> get props => [message, data, error];
}
