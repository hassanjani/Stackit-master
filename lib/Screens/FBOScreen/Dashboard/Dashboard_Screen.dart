// import 'package:aircraft/bar.dart';
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/Dashboard/sample_view.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'ActivitiesModel.dart';
import 'ArrivalsModel.dart';

class Dashboard_Screen extends StatefulWidget {
  const Dashboard_Screen({Key key}) : super(key: key);

  @override
  _Dashboard_ScreenState createState() => _Dashboard_ScreenState();
}

class _Dashboard_ScreenState extends State<Dashboard_Screen> {
  List users = [];
  TooltipBehavior _tooltip;
  TooltipBehavior _tooltip1;
  bool check = true;

  final _data1 = <double, double>{
    1: 1,
  };

  // final _data2 = <double, double>{1: 9, 2: 12, 3: 10};
  // final _data2 = <double, double>{1: 8, 2: 15, 3: 17};

  @override
  void initState() {
    // TODO: implement initState
    _tooltip = TooltipBehavior(enable: true, format: 'point.x : point.y%');
    _tooltip1 = TooltipBehavior(enable: true, format: 'point.x : point.y%');
    getData();
    super.initState();
    check = false;
  }

  @override
  Widget build(BuildContext context) {
    final barGroups = <BarChartGroupData>[
      for (final entry in _data1.entries)
        BarChartGroupData(
          x: entry.key.toInt(),
          barRods: [
            BarChartRodData(y: entry.value, colors: [Colors.blue]),
            // BarChartRodData(y: _data2[entry.key], colors: [Colors.red]),
          ],
        ),
    ];

    /// !!Step3: prepare barChartData
    final barChartData = BarChartData(
      maxY: 26,
      minY: 0,
      // borderData: FlBorderData(
      //     border: Border.all(color: Colors.white)),
      // ! The data to show
      barGroups: barGroups,
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          maxContentWidth: 0,
          tooltipBgColor: Colors.blueGrey,
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false, // this is false by-default.
        ),
        leftTitles: SideTitles(
          showTitles: true,
          // ! Decides how to show left titles,
          // here we skip some values by returning ''.
          getTitles: (double val) {
            if (val.toInt() % 10 != 0) return '';
            return '${val.toInt()}';
          },
        ),
      ),
    );
    return Scaffold(
      body: check
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        margin: EdgeInsets.only(left: 8, bottom: 3, top: 8),
                        // alignment: Alignment.center,
                        // decoration:
                        //     BoxDecoration(border: Border.all(color: Colors.black)),
                        child: Text("Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18))),
                    ////////////////////////////////////////
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: activities != null
                                ? _buildDefaultDoughnutChart1(
                                    int.parse(T_activities),
                                    int.parse(P_activities))
                                : Container(),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                gridcheck = 1;
                              });
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      width: 150,
                                      child: Row(children: [
                                        Text("$P_activities/$T_activities",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold))
                                      ])),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        gridcheck = 1;
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      child: Text(
                                        "Pending Activities",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        gridcheck = 1;
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      child: Text(
                                        "Total Activities",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: activities != null
                                ? _buildDefaultDoughnutChart(
                                    int.parse(T_arrivals),
                                    int.parse(P_arrivals))
                                : Container(),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                gridcheck = 2;
                              });
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        Text(
                                          "$P_arrivals/$T_arrivals",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        gridcheck = 2;
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      child: Text(
                                        "Pending Arrivals",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    child: Text("Total Arrivals"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Image.asset(
                          //   'Images/Pict.png',
                          //   width: 100,
                          //   height: 30,
                          // )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 80,
                              width: 100,
                              child: BarChart(barChartData)),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(
                                    "$Average_services",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      gridcheck = 2;
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    child: Text(
                                      "Average Services",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    width: 150,
                                    child: Text("Provided per Building"))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //////////////////////////////////////////

                    //////////////////////////////////////////
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text(
                        "Click on any of the data above, Client will be able to see detailed Grid",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Grid(gridcheck),
                  ],
                ),
              ),
            ),
    );
  }

  int gridcheck = 0;

  Widget Grid(int check) {
    List<dynamic> data;
    List<dynamic> data1;
    if (check == 1) {
      data = activities.pendingActivities;
      data1 = activities.totalActivities;
    } else if (check == 2) {
      data = arrivals.pendingArrivals;
      data1 = arrivals.totalArrivals;
    } else {}

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 150,
            height: 40,
            margin: EdgeInsets.only(left: 8, bottom: 3, top: 8),
            alignment: Alignment.centerLeft,
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Text(
                check == 0
                    ? "Pending Activity"
                    : check == 1
                        ? "Pending Activity"
                        : "Pending Arrivals",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18))),
        Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: Table(
              border: TableBorder.all(color: Colors.blue, width: 1.0),
              children: [
                TableRow(children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 14,
                    color: Colors.grey.shade400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Building Name',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 14,
                    color: Colors.grey.shade400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Pending Activity',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: Table(
                border: TableBorder.all(color: Colors.blue, width: 1.0),
                children: check == 0
                    ? []
                    : data != null
                        ? data
                            .map((value) => TableRow(children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 14,
                                    // color: users.indexOf(context) % 1 == 0
                                    //     ? Colors.blue[50]
                                    //     : Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${value.buildingName}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  ),
                                  Container(
                                    // color: users.indexOf(context) % 1 == 0
                                    //     ? Colors.blue[50]
                                    //     : Colors.white,
                                    height:
                                        MediaQuery.of(context).size.height / 14,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          check == 1
                                              ? '${value.pendingActivity}'
                                              : '${value.totalActivity}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  ),
                                ]))
                            .toList()
                        : []),
          ),
        ])),
        SizedBox(height: 20),
        //////////////////////////Total Activity////////////////////
        Container(
            width: 150,
            height: 40,
            margin: EdgeInsets.only(left: 8, bottom: 3, top: 8),
            alignment: Alignment.centerLeft,
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Text(
                check == 0
                    ? "Total Activity"
                    : check == 1
                        ? "Total Activity"
                        : "Total Arrivals",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18))),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: Table(
                  border: TableBorder.all(color: Colors.blue, width: 1.0),
                  children: [
                    TableRow(children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 14,
                        color: Colors.grey.shade400,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Building Name',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 14,
                        color: Colors.grey.shade400,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Total Activity',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: Table(
                    border: TableBorder.all(color: Colors.blue),
                    children: check == 0
                        ? []
                        : data1 != null
                            ? data1
                                .map((value) => TableRow(children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                14,
                                        // color: users.indexOf(context) % 1 == 0
                                        //     ? Colors.blue[50]
                                        //     : Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('${value.buildingName}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ),
                                      ),
                                      Container(
                                        // color: users.indexOf(context) % 1 == 0
                                        //     ? Colors.blue[50]
                                        //     : Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                14,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('${value.totalActivity}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ),
                                      ),
                                    ]))
                                .toList()
                            : []),
              )
            ]),
      ],
    );
  }

  SfCircularChart _buildDefaultDoughnutChart(int total, int pending) {
    return SfCircularChart(
      legend:
          Legend(isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
      series: _getDefaultDoughnutSeries(total, pending),
      tooltipBehavior: _tooltip,
      borderColor: Colors.white,
    );
  }

  SfCircularChart _buildDefaultDoughnutChart1(int total, int pending) {
    return SfCircularChart(
      legend:
          Legend(isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
      series: _getDefaultDoughnutSeries(total, pending),
      tooltipBehavior: _tooltip1,
      borderColor: Colors.white,
    );
  }

  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries(
      int total, int pending) {
    double a = (pending * 100) / total;
    a = a.roundToDouble();
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          radius: '100%',
          explode: true,
          explodeOffset: '10%',
          dataSource: <ChartSampleData>[
            ChartSampleData(
                x: 'Pending',
                y: a,
                text: '$pending%',
                pointColor: Colors.green),
            ChartSampleData(
                x: 'Done',
                y: 100 - a,
                text: '${total - pending}%',
                pointColor: Colors.blue),
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true))
    ];
  }

  String P_activities, T_activities, P_arrivals, T_arrivals, Average_services;

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var urlsumary = Uri.parse(
        'http://wordpresswebsiteprogrammer.com/stackit/public/api/dashboard-api?type=summary&id=$id');
    print('working');
    try {
      print('inside try');
      Response response = await get(urlsumary);
      print('done');
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Success');
        print(response.body);
        var jsondata = jsonDecode(response.body);
        P_activities = jsondata["pending_activities"].toString();
        T_activities = jsondata["total_activities"].toString();
        P_arrivals = jsondata["pending_arrivals"].toString();
        T_arrivals = jsondata["total_arrivals"].toString();
        Average_services = jsondata["average_services"].toString();
        setState(() {});
      }
    } catch (e) {
      return null;
    }

    //getActivities

    print('working');
    try {
      final prefs = await SharedPreferences.getInstance();
      String id = await prefs.getString('userid');
      var urlactivities = Uri.parse(
          'http://wordpresswebsiteprogrammer.com/stackit/public/api/dashboard-api?type=activities&id=$id');
      print('inside try');
      Response response = await get(urlactivities);
      print('done');
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Success');
        print(response.body);
        var jsondata = jsonDecode(response.body);
        print(jsondata);
        activities = Activities.fromMap(json.decode(response.body));
        print(activities.totalActivities[0].buildingName);

        setState(() {});
      }
    } catch (e) {
      return null;
    }

    //getArrivals

    print('working');
    try {
      final prefs = await SharedPreferences.getInstance();
      String id = await prefs.getString('userid');
      var urlarrivals = Uri.parse(
          'http://wordpresswebsiteprogrammer.com/stackit/public/api/dashboard-api?type=arrivals&id=$id');
      print('inside try');
      Response response = await get(urlarrivals);
      print('done');
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Success');
        print(response.body);
        var jsondata = jsonDecode(response.body);
        print(jsondata);
        arrivals = Arrivals.fromMap(jsonDecode(response.body));
        print(arrivals.pendingArrivals);

        setState(() {});
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Activities activities;
  Arrivals arrivals;
}
