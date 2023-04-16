import 'package:covid_tracker/View/World_States.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name,
      totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      recovered,
      image,
      test;
  DetailsScreen(
      {required this.active,
      required this.image,
      required this.critical,
      required this.name,
      required this.test,
      required this.recovered,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      Key? key})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .086),
                        ReusableRow(title: "Cases", value: widget.totalCases),
                        ReusableRow(title: "Active", value: widget.active),
                        ReusableRow(title: "Crictical", value: widget.critical),
                        ReusableRow(
                            title: "Recovered", value: widget.recovered),
                        ReusableRow(title: "Tests", value: widget.test),
                        ReusableRow(
                            title: "Total Deaths", value: widget.totalDeaths),
                        ReusableRow(
                            title: "Total Recovered",
                            value: widget.totalRecovered)
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                    radius: 60, backgroundImage: NetworkImage(widget.image))
              ],
            )
          ],
        ),
      ),
    );
  }
}
