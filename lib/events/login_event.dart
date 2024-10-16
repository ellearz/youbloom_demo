abstract class LoginEvent {}

class SendOtpEvent extends LoginEvent {
  final String phoneNumber;
  SendOtpEvent(this.phoneNumber);
}

class VerifyOtpEvent extends LoginEvent {
  final String otpCode;
  VerifyOtpEvent(this.otpCode);
}