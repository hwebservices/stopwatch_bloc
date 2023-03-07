import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stopwatch/features/stopwatch/repository/stopwatch_repository.dart';

part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

/// This [Bloc] will handle the event and states as well as the way they need to be injected in the [page]
class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  /// The [repository] will be used to call all methods related to the [events]
  final StopwatchRepository _stopWatchRepository;

  StopwatchBloc({required StopwatchRepository stopWatchRepository})
      : _stopWatchRepository = stopWatchRepository,
        super(StopwatchLoading()) {
    on<StopwatchInitial>(_onStopwatchInitial);
    on<StopwatchStart>(_onStopwatchStart);
    on<StopwatchLap>(_onStopwatchLap);
    on<StopwatchStop>(_onStopwatchStop);
    on<StopwatchReset>(_onStopwatchReset);
  }

  void _onStopwatchInitial(
      StopwatchInitial event, Emitter<StopwatchState> emit) {
    emit(StopwatchLoaded(isRunning: false, duration: 0));
  }

  void _onStopwatchStart(StopwatchStart event, Emitter<StopwatchState> emit) {
    final start = _stopWatchRepository.startStopwatch();
    emit(StopwatchLoaded(isRunning: true, duration: start));
  }

  void _onStopwatchLap(StopwatchLap event, Emitter<StopwatchState> emit) {
    final lap = _stopWatchRepository.lapStopwatch();
    emit(StopwatchLoaded(isRunning: true, duration: lap));
  }

  void _onStopwatchStop(StopwatchStop event, Emitter<StopwatchState> emit) {
    final stop = _stopWatchRepository.stopStopwatch();
    emit(StopwatchLoaded(isRunning: false, duration: stop));
  }

  void _onStopwatchReset(StopwatchReset event, Emitter<StopwatchState> emit) {
    final reset = _stopWatchRepository.resetStopwatch();
    emit(StopwatchLoaded(isRunning: false, duration: reset));
  }
}
