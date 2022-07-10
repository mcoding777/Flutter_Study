part of 'counter_bloc.dart';

@immutable
abstract class CounterState {
  final int count;
  const CounterState(this.count);
}
