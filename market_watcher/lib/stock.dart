import 'dart:async';
import 'dart:math';

class Stock {
  final String symbol;
  final double price;
  final double dailyChange;

  Stock({
    required this.symbol,
    required this.price,
    required this.dailyChange,
  });

  Stock copyWith({
    String? symbol,
    double? price,
    double? dailyChange,
  }) {
    return Stock(
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
      dailyChange: dailyChange ?? this.dailyChange,
    );
  }
}

enum StockAction {
  Increase,
  Decrease,
  Reset
}

class StockBloc {
  final Stock _startingStock = Stock(
    symbol: 'AAPL',
    price: 180.0,
    dailyChange: 0.0,
  );

  late Stock _currentStock;

  final StreamController<StockAction> _inputController =
      StreamController<StockAction>();

  final StreamController<Stock> _outputController =
      StreamController<Stock>.broadcast();

  final Random _random = Random();

  StockBloc() {
    _currentStock = _startingStock;

    _inputController.stream.listen((action) {
      double change = _random.nextDouble() * 2;

      switch (action) {
        case StockAction.Increase:
          change = change;
          break;
        case StockAction.Decrease:
          change = -change;
          break;
        case StockAction.Reset:
          _currentStock = _startingStock.copyWith();
          _outputController.sink.add(_currentStock);
          return;
      }

      _currentStock = _currentStock.copyWith(
        price: _currentStock.price + change,
        dailyChange: _currentStock.dailyChange + change,
      );

      _outputController.sink.add(_currentStock);
    });
  }

  Stream<Stock> get stockStream => _outputController.stream;

  Sink<StockAction> get actionSink => _inputController.sink;

  Stock get currentStock => _currentStock;
}
