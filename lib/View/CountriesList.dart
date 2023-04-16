import 'dart:convert';

import 'package:covid_tracker/View/Details_Screens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class Countries_List extends StatefulWidget {
  const Countries_List({Key? key}) : super(key: key);

  @override
  State<Countries_List> createState() => _Countries_ListState();
}

class _Countries_ListState extends State<Countries_List> {
  TextEditingController searchController = TextEditingController();
  countryListApi() async {
    var response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    //StatesServices stateddd = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                  hintText: "Search with Country Name",
                  label: Text("Country Name"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: countryListApi(),

            //stateddd.countriesListApi(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              minLeadingWidth: 20,
                              title: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ));
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = snapshot.data[index]["country"];
                    if (searchController.text.isEmpty) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                        image: snapshot.data[index]
                                                ["countryInfo"]["flag"]
                                            .toString(),
                                        active: snapshot.data[index]["active"]
                                            .toString(),
                                        critical: snapshot.data[index]["critical"]
                                            .toString(),
                                        name: snapshot.data[index]["country"]
                                            .toString(),
                                        test: snapshot.data[index]["tests"]
                                            .toString(),
                                        recovered: snapshot.data[index]["recovered"]
                                            .toString(),
                                        totalCases: snapshot.data[index]["cases"]
                                            .toString(),
                                        totalDeaths:
                                            snapshot.data[index]["deaths"].toString(),
                                        totalRecovered: snapshot.data[index]["recovered"].toString()),
                                  ));
                            },
                            child: ListTile(
                                minLeadingWidth: 20,
                                title: Text(
                                  snapshot.data[index]["country"].toString(),
                                ),
                                subtitle: Text(
                                  snapshot.data[index]["cases"].toString(),
                                ),
                                leading: Image.network(
                                  snapshot.data[index]["countryInfo"]["flag"]
                                      .toString(),
                                  height: 50,
                                  width: 50,
                                )),
                          )
                        ],
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                        image: snapshot.data[index]
                                                ["countryInfo"]["flag"]
                                            .toString(),
                                        active: snapshot.data[index]["active"]
                                            .toString(),
                                        critical: snapshot.data[index]["critical"]
                                            .toString(),
                                        name: snapshot.data[index]["country"]
                                            .toString(),
                                        test: snapshot.data[index]["tests"]
                                            .toString(),
                                        recovered: snapshot.data[index]["recovered"]
                                            .toString(),
                                        totalCases: snapshot.data[index]["cases"]
                                            .toString(),
                                        totalDeaths:
                                            snapshot.data[index]["deaths"].toString(),
                                        totalRecovered: snapshot.data[index]["recovered"].toString()),
                                  ));
                            },
                            child: ListTile(
                                minLeadingWidth: 20,
                                title: Text(
                                  snapshot.data[index]["country"].toString(),
                                ),
                                subtitle: Text(
                                  snapshot.data[index]["cases"].toString(),
                                ),
                                leading: Image.network(
                                  snapshot.data[index]["countryInfo"]["flag"]
                                      .toString(),
                                  height: 50,
                                  width: 50,
                                )),
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
