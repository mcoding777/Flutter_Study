part of 'counter_bloc.dart';

@immutable
abstract class CountState {
  final int count;
  const CountState(this.count);
}

class CounterState extends CountState {
  const CounterState(super.count);
}
