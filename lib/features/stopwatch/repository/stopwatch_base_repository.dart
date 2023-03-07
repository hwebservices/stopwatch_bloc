import 'dart:async';

/// This Class contains the methods that will be [overrided] within the repository class
abstract class BaseStopwatchRepository {
  void updateStopwatch(Timer timer);
  int startStopwatch();
  int lapStopwatch();
  int stopStopwatch();
  int resetStopwatch();
}
