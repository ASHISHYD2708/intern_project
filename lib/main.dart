import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intern_project/api_service.dart';
import 'package:intern_project/models/bank_nodels.dart';
import 'package:intern_project/models/performace.dart';

void main() {
  // runApp(const AppScreen());
}

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late Future<Bank?> bank;
  late Future<List<Performance>?> performance;
  @override
  void initState() {
    bank = ApiService.getBankDetail();
    performance = ApiService.getPerformance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 300,
                  width: width,
                  child: FutureBuilder<Bank?>(
                      future: bank,
                      builder: (_, aData) {
                        if (aData.connectionState == ConnectionState.done) {
                          final data = aData.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [Text('Sector'), Text(data.sector!)],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Industry'),
                                  Text(data.industry!)
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Market Cap.'),
                                    Text((data.mCAP! / 100000000)
                                            .toStringAsFixed(2) +
                                        'Cr.')
                                  ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Enterprise value'),
                                  Text(data.eV ?? '-')
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Book value'),
                                  Text(data.bookNavPerShare!.toStringAsFixed(2))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Price Earning ratio(PE)'),
                                  Text(data.pEGRatio!.toStringAsFixed(2))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('PEG ratio'),
                                  Text(data.pEGRatio!.toStringAsFixed(2))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Dividend yield'),
                                  Text(data.yield!.toStringAsFixed(2))
                                ],
                              ),
                            ],
                          );
                        }

                        return const CircularProgressIndicator();
                      }),
                ),
                SizedBox(
                  height: 400,
                  width: width,
                  child: FutureBuilder<List<Performance>?>(
                      future: performance,
                      builder: (_, aData) {
                        if (aData.connectionState == ConnectionState.done) {
                          final data = aData.data!;
                          return SizedBox(
                            height: 400,
                            width: width,
                            child: Column(
                                children: data.map((e) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(child: Text(e.label! + '    ')),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 20,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.grey,
                                          color: e.changePercent! < 0
                                              ? Colors.red
                                              : Colors.green,
                                          value: e.changePercent!.abs() / 100,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        e.changePercent! < 0
                                            ? const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.arrow_drop_up,
                                                color: Colors.green,
                                              ),
                                        Text(
                                          e.changePercent!
                                                  .toStringAsPrecision(3) +
                                              '%',
                                          style: TextStyle(
                                            color: e.changePercent! < 0
                                                ? Colors.red
                                                : Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }).toList()),
                          );
                        }

                        return const CircularProgressIndicator();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
