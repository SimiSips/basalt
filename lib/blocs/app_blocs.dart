import 'package:basalt/repos/repositories.dart';
import 'app_events.dart';
import 'app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class StockBloc extends Bloc<StockEvent, StockState> {
  final StockRepository _stockRepository;

  StockBloc(this._stockRepository) : super(StockLoadingState()) {
    on<LoadStockEvent>((event, emit) async {
      emit(StockLoadingState());
      try {
        final stocks = await _stockRepository.getStocks();
        emit(StockLoadedState(stocks));
      } catch (e) {
        emit(StockErrorState(e.toString()));
      }

    });
  }
}