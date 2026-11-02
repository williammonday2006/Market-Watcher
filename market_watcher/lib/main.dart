import 'package:flutter/material.dart';
import 'stock.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StockPage(),
  ));
}

class StockPage extends StatelessWidget {
  final StockBloc stockBloc = StockBloc();

  StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Watcher'),
        centerTitle: true,
      ),
      body: StreamBuilder<Stock>(
        stream: stockBloc.stockStream,
        initialData: stockBloc.currentStock,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final stock = snapshot.data!;

          Color priceColor = Colors.grey;

          if (stock.dailyChange > 0) {
            priceColor = Colors.green;
          } else if (stock.dailyChange < 0) {
            priceColor = Colors.red;
          }

          return Center(
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      stock.symbol,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '\$${stock.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: priceColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Daily Change: ${stock.dailyChange.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        color: priceColor,
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        stockBloc.actionSink.add(StockAction.Increase);
                      },
                      child: const Text('Bull Market'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        stockBloc.actionSink.add(StockAction.Decrease);
                      },
                      child: const Text('Bear Market'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        stockBloc.actionSink.add(StockAction.Reset);
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
