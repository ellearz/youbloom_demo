
import 'package:youbloom/models/concert_model.dart';

import 'package:equatable/equatable.dart';


abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object?> get props => [];
}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final Concert concert;

  const DetailsLoaded(this.concert);

  @override
  List<Object?> get props => [concert];
}

class DetailsError extends DetailsState {
  final String message;

  const DetailsError(this.message);

  @override
  List<Object?> get props => [message]; 
}
