import 'package:basalt/models/stock_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.e}) : super(key: key);
  final StockModel e;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [


              Card(
                color: Colors.blue,
                elevation: 4,

                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(e.name, style: const TextStyle(
                          color: Colors.white
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(e.symbol, style: const TextStyle(
                          color: Colors.white
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(e.exName, style: const TextStyle(
                          color: Colors.white
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(e.acronym, style: const TextStyle(
                          color: Colors.white
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(e.mic, style: const TextStyle(
                          color: Colors.white
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(e.country, style: const TextStyle(
                          color: Colors.white
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(e.city, style: const TextStyle(
                          color: Colors.white
                      ),),
                    ),

                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
