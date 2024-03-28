import 'package:covide19/view/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,tests;

  DetailScreen({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.tests,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .06,),
                        ReusableRow(title: 'name', value: widget.name.toString()),
                        ReusableRow(title: 'totalCases', value: widget.totalCases.toString()),
                        ReusableRow(title: 'totalRecovered', value: widget.totalRecovered.toString()),
                        ReusableRow(title: 'cases', value: widget.todayRecovered.toString()),
                        ReusableRow(title: 'todayRecovered', value: widget.totalDeaths.toString()),
                        ReusableRow(title: 'critical', value: widget.critical.toString()),
                        ReusableRow(title: 'active', value: widget.active.toString()),
                        ReusableRow(title: 'tests', value: widget.tests.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
