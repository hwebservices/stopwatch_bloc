part of 'stopwatch_bloc.dart';

abstract class StopwatchState extends Equatable {
  const StopwatchState();

  @override
  List<Object> get props => [];
}

/// For this particular scenario it will be better to define two [states] only
/// and the data will be handled by the specific method called in the [Bloc] directly
class StopwatchLoading extends StopwatchState {}

class StopwatchLoaded extends StopwatchState {
  const StopwatchLoaded({
    this.isRunning,
    required this.duration,
  });

  final bool? isRunning;
  final int duration;

  @override
  List<Object> get props => [isRunning!, duration];
}
