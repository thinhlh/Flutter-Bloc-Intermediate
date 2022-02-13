import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/widgets.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterValue()) {
    on<IncrementCounter>(
      (event, emit) async {
        emit(CounterLoading()..value = state.value);

        await Future.delayed(const Duration(seconds: 2));

        emit(CounterValue()..value = state.value + 1);
      },
      transformer: sequential(),
    );

    on<DecrementCounter>(
      (event, emit) async {
        emit(CounterLoading()..value = state.value);

        await Future.delayed(const Duration(seconds: 2));

        emit(CounterValue()..value = state.value - 1);
      },
      transformer: sequential(),
    );
  }
}
