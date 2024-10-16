import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LogInitial extends LoginState {}

class LogLoading extends LoginState {}

class OtpSentState extends LoginState {
  final String verificationId;

  const OtpSentState(this.verificationId);

  @override
  List<Object?> get props => [verificationId]; 
}

class LogSuccess extends LoginState {}

class LogFailure extends LoginState {
  final String message;

  const LogFailure(this.message);

  @override
  List<Object?> get props => [message]; 
}

