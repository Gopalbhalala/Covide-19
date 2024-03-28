import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../services/states_services.dart';
import '../services/utilities/favourite_item.dart';
import 'detail_screen.dart';

class MyFavouriteScreen extends StatefulWidget {
  const MyFavouriteScreen({Key? key}) : super(key: key);

  @override
  State<MyFavouriteScreen> createState() => _MyFavouriteScreenState();
}



class _MyFavouriteScreenState extends State<MyFavouriteScreen> with TickerProviderStateMixin {

  TextEditingController searchController = TextEditingController();

  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Favourite'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
       
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)
                    )
                ),
              )
          ),

          Expanded(
              child: FutureBuilder(
                  future: statesServices.fecthCountriesList(),
                  builder: (BuildContext context,AsyncSnapshot<List<dynamic>> snapshot) {

                    var data=snapshot.data;

                    if(!snapshot.hasData){
                      // return Text('Loading...');
                      return ListView.builder(
                          itemCount: 15,
                          itemBuilder: (context,index){

                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal:8),
                                    child: ListTile(
                                      leading: Container(height: 80,width: 80,color: Colors.white,),
                                      title: Container(height: 10,width: 89,color: Colors.white,),
                                      subtitle: Container(height: 8,width: 89,color: Colors.white,),
                                    ),
                                  )
                                ],
                              ),
                            );

                          });
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){

                            String name = data![index]['country'];

                            if(searchController.text.isEmpty){
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal:8),
                                    child: InkWell(
                                      onTap:(){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>
                                                DetailScreen(
                                                  name: data![index]['country'],
                                                  image: data![index]['countryInfo']['flag'],
                                                  totalCases: data![index]['cases'],
                                                  totalDeaths: data![index]['deaths'],
                                                  totalRecovered: data![index]['recovered'],
                                                  active: data![index]['active'],
                                                  critical: data![index]['critical'],
                                                  todayRecovered: data![index]['todayRecovered'],
                                                  tests: data![index]['tests'],
                                                ),));
                                      },
                                      child: ListTile(
                                        leading: Image.network(data![index]['countryInfo']['flag'],height: 80,width: 80,),
                                        title: Text(data![index]['country']),
                                        subtitle: Text(data![index]['cases'].toString()),
                                        trailing: IconButton(
                                          onPressed: (){
                                            // selectedItem.add(index);
                                            // setState(() {
                                            //
                                            // });



                                          },
                                          icon: Icon( Icons.favorite_outline,),
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );

                            }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal:8),
                                    child: InkWell(
                                      onTap : (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>
                                                DetailScreen(
                                                  name: data![index]['country'],
                                                  image: data![index]['countryInfo']['flag'],
                                                  totalCases: data![index]['cases'],
                                                  totalDeaths: data![index]['deaths'],
                                                  totalRecovered: data![index]['recovered'],
                                                  active: data![index]['active'],
                                                  critical: data![index]['critical'],
                                                  todayRecovered: data![index]['todayRecovered'],
                                                  tests: data![index]['tests'],
                                                ),));
                                      },
                                      child: ListTile(
                                        leading: Image.network(data![index]['countryInfo']['flag'],height: 80,width: 80,),
                                        title: Text(data![index]['country']),
                                        subtitle: Text(data![index]['cases'].toString()),
                                        trailing: IconButton(
                                          onPressed: (){
                                            // selectedItem.add(index);
                                            // setState(() {
                                            //
                                            // });



                                          },
                                          icon: Icon(   Icons.favorite_outline,),
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );

                            }else{
                              return Container();
                            }

                          });
                    }


                  }
              ))

        ],
      ),
    );

  }
}
