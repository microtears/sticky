import 'package:meta/meta.dart';

@immutable
class Pair<A, B> {
  final A first;
  final B second;

  const Pair(this.first, this.second);

  Pair<A, B> copyWith(A first, B second) {
    return Pair(first ?? this.first, second ?? this.second);
  }
}
