import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youbloom/bloc/login_bloc.dart'; // Adjust the path if needed
import 'package:youbloom/events/login_event.dart';
import 'package:youbloom/states/login_state.dart';

void main() {
  group('LoginBloc', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = LoginBloc();
    });

    tearDown(() {
      loginBloc.close();
    });

    test('initial state is LogInitial', () {
      expect(loginBloc.state, equals(LogInitial()));
    });

    blocTest<LoginBloc, LoginState>(
      'emits [LogLoading, OtpSentState] when sending OTP is successful',
      build: () => loginBloc,
      act: (bloc) => bloc.add(SendOtpEvent("+49123456789")),
      expect: () => [
        LogLoading(),
        OtpSentState("demoVerificationId"),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LogLoading, LogFailure] when sending OTP with incorrect phone number',
      build: () => loginBloc,
      act: (bloc) => bloc.add(SendOtpEvent("+49000000000")),
      expect: () => [
        LogLoading(),
        LogFailure("Phone number is incorrect"),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LogLoading, LogSuccess] when verifying OTP is successful',
      build: () => loginBloc,
      act: (bloc) {
        bloc.add(SendOtpEvent("+49123456789")); 
        return Future.delayed(const Duration(milliseconds: 500), () {
          bloc.add(VerifyOtpEvent("123456")); 
        });
      },
      expect: () => [
        LogLoading(),
        OtpSentState("demoVerificationId"), 
        LogLoading(),
        LogSuccess(), 
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LogLoading, LogFailure] when verifying OTP with incorrect code',
      build: () => loginBloc,
      act: (bloc) {
        bloc.add(SendOtpEvent("+49123456789")); 
        return Future.delayed(const Duration(milliseconds: 500), () {
          bloc.add(VerifyOtpEvent("000000")); 
        });
      },
      expect: () => [
        LogLoading(),
        OtpSentState("demoVerificationId"), 
        LogLoading(),
        LogFailure("Invalid OTP"), 
      ],
    );
  });
}
