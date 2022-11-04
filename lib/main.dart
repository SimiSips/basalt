import 'dart:async';

import 'package:basalt/blocs/app_blocs.dart';
import 'package:basalt/blocs/app_events.dart';
import 'package:basalt/blocs/app_states.dart';
import 'package:basalt/repos/repositories.dart';
import 'package:basalt/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'models/stock_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: RepositoryProvider(
          create: (context) => StockRepository(),
          child: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<StockModel> _foundStocks = [];
  List<StockModel> stocksList = [];

  late StreamSubscription connection;
  bool isoffline = false;


  @override
  initState(){
    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.ethernet){
        //connection is from wired connection
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.bluetooth){
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
        });
      }
    });
    _foundStocks = stocksList;
    super.initState();
  }

  @override
  void dispose() {
    connection.cancel();
    super.dispose();
  }

  void _runFilter(String enteredKeyword) {
    List<StockModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = stocksList;
    } else {
      results = stocksList.where((stock) => stock.name.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();

    }

    setState(() {
      _foundStocks = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => StockBloc(
          RepositoryProvider.of<StockRepository>(context),
        )..add(LoadStockEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Basalt Assessment"),
        ),
        body: BlocBuilder<StockBloc, StockState>(
          builder: (context, state) {

            if (isoffline == true) {
              return Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom:30),
                color: isoffline?Colors.red:Colors.lightGreen,
                padding:EdgeInsets.all(10),
                child: Text(isoffline?"Device is Offline":"Device is Online",
                  style: TextStyle(
                      fontSize: 20, color: Colors.white
                  ),),
              );
            } else {

              if (state is StockLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is StockLoadedState) {
                List<StockModel> stockList = state.stocks;
                /* setState(() {
                stocksList = stockList;
              });*/
                return Column(
                  children: [
                    TextField(
                      onChanged: (value) => _runFilter(value),
                      decoration: const InputDecoration(
                          labelText: 'Search', suffixIcon: Icon(Icons.search)
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: stockList.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(
                                              e: stockList[index],
                                            ))
                                );
                              },
                              child: Card(
                                color: Colors.blue,
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10),
                                child: ListTile(
                                  title: Text(
                                    stockList[index].name, style: TextStyle(
                                      color: Colors.white
                                  ),),
                                  subtitle: Text(stockList[index].symbol,
                                    style: const TextStyle(
                                        color: Colors.white
                                    ),),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              if (state is StockErrorState) {
                return Center(
                  child: Text("Error"),
                );
              }
            }
            return Container();
          },
        ),
    ),
    );
  }
}

