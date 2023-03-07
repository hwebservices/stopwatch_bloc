part of 'stopwatch_bloc.dart';

abstract class StopwatchEvent extends Equatable {
  const StopwatchEvent();

  @override
  List<Object> get props => [];
}

/// Create the [Events] that we will read in the [page]
class StopwatchInitial extends StopwatchEvent {}

class StopwatchStart extends StopwatchEvent {}

class StopwatchLap extends StopwatchEvent {}

class StopwatchStop extends StopwatchEvent {}

class StopwatchReset extends StopwatchEvent {}
