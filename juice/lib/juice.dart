/// Support for doing something awesome.
///
/// More dartdocs go here.
library juice;

import 'dart:developer';

export 'src/juice_base.dart';
export 'src/file_size_unit.dart';
export 'src/pair.dart';

typedef ResultCallback<T> = T Function();

typedef VoidCallback = void Function();

typedef TestCallback<T> = bool Function(T value);

T run<T>(ResultCallback<T> action) {
  return action();
}

void repeat(int conut, VoidCallback action) {
  for (var i = 0; i < conut; i++) {
    action();
  }
}

T tryRun<T>(T defaultValue, ResultCallback<T> action, {TestCallback<T> test}) {
  try {
    final T value = action();
    if (test == null) {
      return value;
    }
    if (test(value)) {
      return value;
    } else {
      throw TestValueFailedException(value);
    }
  } catch (e) {
    log(e.toString());
    return defaultValue;
  }
}

class TestValueFailedException<T> implements Exception {
  final String message;

  final T value;

  TestValueFailedException(this.value, [this.message = ""]);

  @override
  String toString() {
    String report = "FormatException";
    if (message != null && "" != message) {
      report = "$report: $message";
    }
    report = "$report, value: $value";
    return report;
  }
}
