import 'package:covide19/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../model/world_states_model.dart';
import 'countries_list_screen.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
  duration: Duration(seconds: 3),
  vsync: this)..repeat();

  @override
  void dispose() {
  // TODO: implement dispose
  super.dispose();
  _controller.dispose();
  }


  final colorList=<Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];


  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(title: Text("Covide-19"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01,),
              FutureBuilder(
                  future: statesServices.fecthWorldStatesRecords(),
                  builder: (BuildContext context,AsyncSnapshot snapshot){

                    WorldStatesModel data = snapshot.data;

                    if(!snapshot.hasData){
                      return Expanded(
                          child: SpinKitFadingCircle(
                            controller: _controller,
                            size: 50.0,
                            color: Colors.white,
                          ));
                    }else{
                      return Column(
                        children: [

                          PieChart(
                            dataMap: {
                              "Total" : double.parse(data.cases!.toString()),
                              "Recovered" : double.parse(data.recovered!.toString()),
                              "Deaths" : double.parse(data.deaths!.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true
                            ),
                            chartRadius: MediaQuery.of(context).size.width /3.2,
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                            child: SingleChildScrollView(
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(title: 'Total',value: data.cases.toString(),),
                                    ReusableRow(title: 'deaths',value: data.deaths.toString(),),
                                    ReusableRow(title: 'recovered',value: data.recovered.toString(),),
                                    ReusableRow(title: 'active',value: data.active.toString(),),
                                    ReusableRow(title: 'critical',value: data.critical.toString(),),
                                    ReusableRow(title: 'todayDeaths',value: data.todayDeaths.toString(),),
                                    ReusableRow(title: 'todayRecovered',value: data.todayRecovered.toString(),),
                                    ReusableRow(title: 'population',value: data.population.toString(),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen(),));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Text("Track Country")),
                            ),
                          ),
                        ],
                      );
                    }
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}


