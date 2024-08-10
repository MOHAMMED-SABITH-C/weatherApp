import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
import 'package:newtok_wether/wether_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherHomePage extends StatefulWidget {
  WeatherHomePage({super.key, required this.city});
  late String city='Londone';

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  // late String country='';
    Future<Welcome> fetchProducts()async{
    String url="https://api.weatherapi.com/v1/forecast.json?key=83ffcffd9a9947ca88f160901240808&q="+widget.city+"&days=7&aqi=no&alerts=no";
    Uri uri=Uri.parse(url);
    final result= await http.get(uri);
    if(result.statusCode==2001 || result.statusCode==200){
       await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // return welcomeFromJson(response);
      print(result);
      return Welcome.fromJson(jsonDecode(result.body));
    }else{
      throw Exception("Fail to load ${widget.city}");
    }
  }
  
  

  // late String day='Monady';

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Weather Report',style: TextStyle(
                color: Color(0xF704357F),
                fontWeight: FontWeight.bold,
                fontSize: 25),),
      ),
      body: FutureBuilder(
                            future: fetchProducts(),
                            // stream: ().snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                               if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                //  else if(snapshot.hasData){
                                }else if (snapshot.hasError) {
                                  print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ){//|| snapshot.data!.current.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
                                  final weather = snapshot.data!;
       return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0,left: 8),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Layout1(city:widget.city,forecast:weather.forecast.forecastday[0]),
              Container(
                
                height: 104,
                width: MediaQuery.of(context).size.width,
                child: 
              Layout2(hour: weather.forecast.forecastday[0].hour,time:weather.current.lastUpdated)),
              Layout3(current:weather.current,),
              SizedBox(height: 10,),
              Layout4(current:weather.current,),
          //  Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(day),
          //                 Text(day),
          //               ],
          //             ),
              SizedBox(height: 10,),
              Container(
                height: 130,
                child: 
              Layout5(forecast: weather.forecast.forecastday,)),
            ],
          ),
        ),
      );
          }
                            },
      )
    );
  }
}

class Layout1 extends StatelessWidget {
    late String city;
    late Forecastday forecast;
  Layout1({key,required this.city,required this.forecast});

  @override
  Widget build(BuildContext context) {
            String dayName = DateFormat('EEEE,dd').format(forecast.date);
    
    return Card(
      child: ListTile(
        title: Text('$city'),
        subtitle: Text('${forecast.day.avgtempC}°C, $dayName'),
      ),
    );
  }
}

class Layout3 extends StatelessWidget {
    late Current current;
  Layout3({super.key,required this.current});
  
  @override
  Widget build(BuildContext context) {
    return Center(
              child: Stack(
                
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:50.0),
                    child: Container(
                      
                      height: 200,
                      width:  300,
                      decoration: BoxDecoration(
                        // boxShadow: [BoxShadow(color: Colors.grey,blurRadius :100.0,
                        //  spreadRadius : 1.0,
                        //  offset:Offset(0, -50) ,blurStyle : BlurStyle.outer)],
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  ),
                  Positioned(
                    top: -12,
                    // child: Image.asset('rain.png',
                    child: Image.network('http:${current.condition.icon}',
                      height: 160,
                      width:  160,
                      // scale: 1,
                      fit: BoxFit.fill,
                      
                      // color: Colors.black,
                    ),
                  ),
                  Positioned(
                    top:115,
                    // height: 1000,
                    right: 20,
                    // alignment: AlignmentDirectional(-100, -200),
                    child: Text('${current.tempC}°',textAlign: TextAlign.right,style: TextStyle(fontSize: 60),)),
                  Positioned(
                    top: 210,
                    left: 20,
                    child: Text(current.condition.text,textAlign: TextAlign.right,style: TextStyle(fontSize: 20),))
              
                ],
              ),
            );
  }
}

class Layout4 extends StatelessWidget {
    late Current current;
  Layout4({key,required this.current});
  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Wind Speed'),
                    Image.asset('wind.jpg',width: 70,height: 70,),
                    Text('${current.windKph}')
                  ],
                ),
                Column(
                  children: [
                    Text('Humidity'),
                    Image.asset('humidity.jpg',width: 70,height: 70,),
                    Text('${current.humidity}')
                  ],
                ),
                Column(
                  children: [
                    Text('Max Temp'),
                    Image.asset('temp.jpg',width: 70,height: 70,),
                    Text('${current.tempC}')
                  ],
                ),
                
              ],
            );
  }
}

// class ForecastTile extends StatelessWidget {
//   final String day;
//   final String temp;

//   ForecastTile({required this.day, required this.temp});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 5),
//       child: Column(
//         children: [
//           Text(day),
//           Text(temp),
//         ],
//       ),
//     );
//   }
// }

class Layout2 extends StatelessWidget {
    late List<Hour> hour;
    int n=0,i=0;
    // DateTime time= DateTime.now();
    String time;
  Layout2({key,required this.hour,required this.time});
  @override
  Widget build(BuildContext context) {
    // Dummy graphical representation
        // late double temp=hour[0].tempC;
      // late String timeN="${time.hour.toString().padLeft(2,'0')}";
      int timeN=int.parse((time).split(' ')[1].split(':')[0]);
    // for(int i=0;i<hour.length;i++){

        int timeS=int.parse((hour[0].time).split(' ')[1].split(':')[0]);
        print('now $timeN list $timeS $time');
      while((timeN > timeS ) && (i<hour.length)){
        timeS=int.parse((hour[i].time).split(' ')[1].split(':')[0]);
        i++;
      }
        n=i;
    // }
      // int index=n;
      return Center(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hour.length-n,
        itemBuilder:(context,index){
          // index=n++;
          // index==0?index=n:n++;
          List<String> time=(hour[index+n].time).split(' ');
          // while (temp==hour[index].tempC){
          //   temp=hour[index++].tempC;
          //   // index++;
          //   // }else{
          //   }
          //     temp=hour[index].tempC;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.black,
                    blurRadius :10.0,
                          //  spreadRadius : 1.0,
                    )]
                  ),
              height:90 ,
              width: 70,
              child: Column(
                        children: [
                          Image.network('https:${hour[index+n].condition.icon}'),//,width: 70,height: 70,),
                          // Text('Wind Speed'),
                          // NetworkImage('https:${hour[index].condition.icon}'),//,width: 70,height: 70,),
                          Text('${time[1]}')
                        ],
                      ),
            ),
          );
        } 
        ),
    );
    // Card(
    //   child: Container(
    //     height: 100,
    //     child: Center(
    //       child: Text('Graphical Representation'),
    //     ),
    //   ),
    // );
  }
}

class Layout5 extends StatelessWidget {
    late List<Forecastday> forecast;
  Layout5({key,required this.forecast});
  @override
  Widget build(BuildContext context) {
    // Dummy map view
    //  late double temp=forecast[0].tempC;
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: forecast.length-1,
      itemBuilder:(context,index){
        // List<String> time=(forecast[index].time).split(' ');
        // while (temp==forecast[index].tempC){
        //   // index++;
        //   temp=forecast[index].tempC;
        //   // }else{
        //   }
            final day=forecast[index+1].day;
            String dayName = DateFormat('EEEE\ndd').format(forecast[index+1].date);
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.circular(10)
          ),
          height:90 ,
          width: 75,
          child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Text(dayName,textAlign: TextAlign.center,),
                      Image.network('https:${day.condition.icon}'),//,width: 70,height: 70,),
                      // NetworkImage('https:${hour[index].condition.icon}'),//,width: 70,height: 70,),
                      Text('${day.avgtempC}°C')
                    ],
                  ),
        );
      } ,
      separatorBuilder:(context,value)=> SizedBox(width: 10,),
      );
    // Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Column(
    //               children: [
    //                 Text('Wind Speed'),
    //                 Image.asset('rain.png',width: 70,height: 70,),
    //                 Text('5k/h')
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 Text('Humidity'),
    //                 Image.asset('rain.png',width: 70,height: 70,),
    //                 Text('53')
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 Text('Max Temp'),
    //                 Image.asset('rain.png',width: 70,height: 70,),
    //                 Text('15dec')
    //               ],
    //             ),
                
    //           ],
    //         );
  }
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:newtok_wether/wether_model.dart';

// class Wetherhome extends StatelessWidget {
//    Wetherhome({super.key,required this.city});
//   late String city='';
//   late String country='India';

//    Future<Welcome> fetchProducts()async{
//     String url="https://api.weatherapi.com/v1/forecast.json?key=83ffcffd9a9947ca88f160901240808&q="+city+"&days=7&aqi=no&alerts=no";
//     Uri uri=Uri.parse(url);
//     final result= await http.get(uri);
//     if(result.statusCode==200 || result.statusCode==201){
//        await Future.delayed(Duration(seconds: 1)); // Simulate network delay
//     // return welcomeFromJson(response);
//       return Welcome.fromJson(jsonDecode(result.body));
//     }else{
//       throw Exception("Fail to load $country");
//     }
//   }
   
//   String api="83ffcffd9a9947ca88f160901240808";
//   // String searchWetherApi= "https://api.weatherapi.com/v1/forecast.json?key=83ffcffd9a9947ca88f160901240808&q="+city+"&days=7&aqi=no&alerts=no";

//   /////////////


//   late String day='Monady';

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(country,textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
//             Row(
//               children: [
//                 Text('$country ,\t\t'),
//                 Text(day)
//               ],
//             ),
//             Center(
//               child: Stack(
                
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top:50.0),
//                     child: Container(
                      
//                       height: 195,
//                       width:  300,
//                       decoration: BoxDecoration(
//                         boxShadow: [BoxShadow(color: Colors.grey,blurRadius :100.0,
//                          spreadRadius : 1.0,
//                          offset:Offset(0, -50) ,blurStyle : BlurStyle.outer)],
//                       color: Colors.lightBlueAccent,
//                       borderRadius: BorderRadius.circular(20)
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: -35,
//                     child: Image.asset('rain.png',
//                       height: 220,
//                       width:  220,
//                       // color: Colors.black,
//                     ),
//                   ),
//                   Positioned(
//                     top:100,
//                     // height: 1000,
//                     right: 40,
//                     // alignment: AlignmentDirectional(-100, -200),
//                     child: Text('17',textAlign: TextAlign.right,style: TextStyle(fontSize: 80),)),
//                   Positioned(
//                     top: 200,
//                     left: 20,
//                     child: Text(country,textAlign: TextAlign.right,style: TextStyle(fontSize: 30),))
              
//                 ],
//               ),
//             ),
//             SizedBox(height: 20,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     Text('Wind Speed'),
//                     Image.asset('rain.png',width: 70,height: 70,),
//                     Text('5k/h')
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text('Humidity'),
//                     Image.asset('rain.png',width: 70,height: 70,),
//                     Text('53')
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text('Max Temp'),
//                     Image.asset('rain.png',width: 70,height: 70,),
//                     Text('15dec')
//                   ],
//                 ),
                
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(day),
//                 Text(day),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     Text('Wind Speed'),
//                     Image.asset('rain.png',width: 70,height: 70,),
//                     Text('5k/h')
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text('Humidity'),
//                     Image.asset('rain.png',width: 70,height: 70,),
//                     Text('53')
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text('Max Temp'),
//                     Image.asset('rain.png',width: 70,height: 70,),
//                     Text('15dec')
//                   ],
//                 ),
                
//               ],
//             ),

//           ],
//         ),
//       ),
//     );
//   }
// }