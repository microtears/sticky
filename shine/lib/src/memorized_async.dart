import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:async/async.dart';

typedef StreamGetter<T> = Stream<T> Function();
typedef FutureGetter<T> = FutureOr<T> Function();

class MemorizedFutureBuilder<T> extends StatefulWidget {
  final FutureGetter<T> future;
  final T initialData;
  final AsyncWidgetBuilder<T> builder;

  const MemorizedFutureBuilder({
    Key key,
    this.future,
    this.initialData,
    @required this.builder,
  }) : super(key: key);

  @override
  _MemorizedFutureBuilderState<T> createState() =>
      _MemorizedFutureBuilderState<T>();
}

class _MemorizedFutureBuilderState<T> extends State<MemorizedFutureBuilder<T>> {
  final _memoizer = AsyncMemoizer<T>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      builder: widget.builder,
      initialData: widget.initialData,
      future: _memoizer.runOnce(widget.future),
    );
  }
}

class StreamMemoizer<T> {
  Stream<T> get stream => _streamReference;
  Stream<T> _streamReference;

  bool get hasRun => _streamReference != null;

  Stream<T> runOnce(Stream<T> computation()) {
    if (!hasRun) _streamReference = computation();
    return stream;
  }
}

class MemorizedStreamBuilder<T> extends StatefulWidget {
  final T initialData;
  final AsyncWidgetBuilder<T> builder;
  final StreamGetter<T> stream;

  const MemorizedStreamBuilder({
    Key key,
    this.initialData,
    this.stream,
    @required this.builder,
  }) : super(key: key);

  @override
  _MemorizedStreamBuilderState<T> createState() =>
      _MemorizedStreamBuilderState<T>();
}

class _MemorizedStreamBuilderState<T> extends State<MemorizedStreamBuilder<T>> {
  final _memoizer = StreamMemoizer<T>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      builder: widget.builder,
      initialData: widget.initialData,
      stream: _memoizer.runOnce(widget.stream),
    );
  }
}
