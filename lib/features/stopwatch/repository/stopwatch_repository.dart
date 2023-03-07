import 'dart:async';

import 'package:stopwatch/features/stopwatch/repository/stopwatch_base_repository.dart';

import '../../../util/utils.dart';

/// Main repository class that will be used to call the methods within the [Bloc] and it extends
/// the base repository class
class StopwatchRepository extends BaseStopwatchRepository {
  final stopwatch = Stopwatch();
  int duration = 0;
  Timer? timer;
  String elapsedTime = '';

  /// Implement the stopwatch [UPDATE]
  @override
  void updateStopwatch(Timer timer) {
    if (stopwatch.isRunning) {
      elapsedTime = Utils.transformMilliSeconds(stopwatch.elapsedMilliseconds);
      print(elapsedTime);
    }
  }

  /// Implement the stopwatch [START]
  @override
  int startStopwatch() {
    stopwatch.start();
    timer = Timer.periodic(const Duration(milliseconds: 1000), updateStopwatch);
    duration = stopwatch.elapsedMilliseconds;
    return duration;
  }

  /// Implement the stopwatch [LAP]
  @override
  int lapStopwatch() {
    stopwatch.stop();
    duration = stopwatch.elapsedMilliseconds;
    Duration elapsed = stopwatch.elapsed;
    assert(stopwatch.elapsed == elapsed);
    stopwatch.start();
    return duration;
  }

  /// Implement the stopwatch [STOP]
  @override
  int stopStopwatch() {
    stopwatch.stop();
    duration = stopwatch.elapsedMilliseconds;
    return duration;
  }

  /// Implement the stopwatch [RESET]
  @override
  int resetStopwatch() {
    stopwatch.stop();
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 0), (_) => updateStopwatch);
    stopwatch.reset();
    return duration;
  }
}
