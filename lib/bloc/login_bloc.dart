import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloom/events/login_event.dart';
import 'package:youbloom/states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final String demoPhoneNumber = "+49123456789"; 
  final String demoOtpCode = "123456"; 

  LoginBloc() : super(LogInitial()) {

    on<SendOtpEvent>((event, emit) async {
      emit(LogLoading());
      try {
        if (event.phoneNumber == demoPhoneNumber) {
          await Future.delayed(const Duration(seconds: 1)); 
          emit(OtpSentState("demoVerificationId")); 
        } else {
          emit(LogFailure("Phone number is incorrect"));
        }
      } catch (e) {
        emit(LogFailure(e.toString()));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(LogLoading());
      try {
        if (event.otpCode == demoOtpCode) {
          await Future.delayed(const Duration(seconds: 1)); 
          emit(LogSuccess()); 
        } else {
          emit(LogFailure("Invalid OTP"));
        }
      } catch (e) {
        emit(LogFailure("Verification failed"));
      }
    });
  }
}
