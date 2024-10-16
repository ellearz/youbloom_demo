
import 'package:youbloom/models/concert_model.dart';

import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object?> get props => [];
}

class MainLoading extends MainState {}

class MainLoaded extends MainState {
  final List<Concert> concerts;

  const MainLoaded(this.concerts);

  @override
  List<Object?> get props => [concerts]; 
}

class MainError extends MainState {
  final String message;

  const MainError(this.message);

  @override
  List<Object?> get props => [message]; 
}
