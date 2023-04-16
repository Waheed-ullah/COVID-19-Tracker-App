import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'CountriesList.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  final colorlist = <Color>[Colors.blue, Colors.green, Colors.red];
  getApi() async {
    var response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                future: getApi(),
                //statesservices.fetchWorldStatesRecords() as Future<WorldStatesModel>,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data["cases"].toString()),
                            "Recovered": double.parse(
                                snapshot.data["recovered"].toString()),
                            "Deaths": double.parse(
                                snapshot.data["deaths"].toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          animationDuration: const Duration(seconds: 3),
                          chartType: ChartType.ring,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          colorList: colorlist,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                    title: "Cases",
                                    value: snapshot.data["cases"].toString()),
                                ReusableRow(
                                    title: "Recovered",
                                    value:
                                        snapshot.data["recovered"].toString()),
                                ReusableRow(
                                    title: "Deaths",
                                    value: snapshot.data["deaths"].toString()),
                                ReusableRow(
                                    title: "Active",
                                    value: snapshot.data["active"].toString()),
                                ReusableRow(
                                    title: "Critical",
                                    value:
                                        snapshot.data["critical"].toString()),
                                ReusableRow(
                                    title: "Affected Countries",
                                    value: snapshot.data["affectedCountries"]
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Countries_List(),
                                ));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                "Track Countries",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                    //return const Text("data is avalible");
                  } else {
                    return Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String? title, value;
  ReusableRow({required this.title, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title.toString()),
              Text(value.toString()),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
