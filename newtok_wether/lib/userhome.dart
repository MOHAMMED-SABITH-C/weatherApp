// import 'dart:io';

// import 'dart:convert';
import 'dart:io';

// import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:newtok_wether/login.dart';
// import 'package:newtok_wether/main.dart';
import 'package:newtok_wether/provider_model.dart';
import 'package:newtok_wether/wetherhome.dart';
import 'package:provider/provider.dart';

class Userhome extends StatefulWidget {
  const Userhome({super.key});

  @override
  State<Userhome> createState() => _UserhomeState();
}

class _UserhomeState extends State<Userhome> {
  String? filePath;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<Detail>(builder: (context, loca, child) {
      return Scaffold(
          backgroundColor: Color.fromARGB(200, 255, 255, 255),
          appBar: AppBar(actions: [
            IconButton(onPressed: (){
              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeScreen()), (route)=>false);
        Navigator.pushNamedAndRemoveUntil(context, '/User',(Route<dynamic> route)=>false);

            }, icon: Icon(Icons.logout_sharp))
          ],
            title: Text('Locations',style: TextStyle(
                color: Color(0xF704357F),
                fontWeight: FontWeight.bold,
                fontSize: 35),),
            centerTitle: true,
          ),
          body: StreamBuilder(
            stream: loca.location.snapshots(),
            builder: (context, snapshot) {
              
              return snapshot.hasData?Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 125),
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.docs[index];
                          return Card(
                            elevation: 5,
                            color: Color.fromARGB(255, 255, 255, 255),
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 0, 0, 0)
                                            .withAlpha(200),
                                        // backgroundBlendMode: BlendMode.color,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8))),
                                    height: height * 0.2,
                                    width: width * 0.2,
                                    alignment: Alignment.topCenter,
                                    child: Center(
                                        child: Text(
                                      '${data['city']}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ))),
                              ),
              
                              title: Text(data['country']), 
                              isThreeLine: true,
                              subtitle: Text(
                                  'State : ${data['state']}\nDistrict : ${data['district']}\nCity : ${data['city']}'),
                              //  trailing: //IconButton(onPressed: (){
              
                              //  }, icon:Icon(Icons.more_vert_outlined,color: Colors.black,)
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        WeatherHomePage(city: data['city'])));
                              },
                            ),
                          );
                          // return Container(
                          //   child:
                          //      InkWell(
                          //       onTap: (){
                          //          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WeatherHomePage(city:data.city)));
              
                          //       },
                          //   child:ListTile(
              
                          //     // elevation: 10,
                          //     // borderOnForeground: false,
                          //     // child:
                          //       child: Column(
                          //         children: [
                          //           Text('Country : ${data.country}',style: TextStyle(fontWeight: FontWeight.bold),),
                          //           Text('State : ${data.state}'),
                          //           Text('District : ${data.district}'),
                          //           Text('City : ${data.city}'),
              
                          //         ],
                          //       ),
                          //     ),
                          //   )
                          // );
                        }),
                  ),
                  Positioned(
                    bottom: 0,
                    // alignment: Alignment.bottomCenter,
                    child: Container(
                      width: width, //MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black,
                              offset: Offset(0, 1))
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        // border:Border(top:BorderSide(width: 1) ),
                      ),
                      //  ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            // Text('Subtotal',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            Text('Import the excel sheet to see weather of city '),
                            //   ],
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: width - 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: const Color.fromARGB(
                                      255, 15, 88, 147), //Colors.blue,
                                  // border: Border.all(width: 1)
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      _pickFile();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: width - (width * 3) / 4 + 5,
                                          right: 30),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Import',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.file_download_outlined,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
              :CircularProgressIndicator();
            }
          ));
    });
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    filePath = result.files.first.path!;

    // final input = File(filePath!).openRead();
    var input = File(filePath!).readAsBytesSync();
    var excel = Excel.decodeBytes(input);
    // final fields = await input
    //     .transform(utf8.decoder)
    //     .transform(const CsvToListConverter())
    //     .toList();
    var sheet = excel.tables[excel.tables.keys.first];
    if (sheet != null && sheet.maxRows > 1) {
      // Assuming the first row is headers, get the second row data
      var row = sheet.row(1);
      Location exceldata = Location(
          country: row[0]!.value.toString(),
          state: row[1]!.value.toString(),
          district: row[2]!.value.toString(),
          city: row[3]!.value.toString());
      //  Provider.of<Detail>(context,listen:false).addLocation(exceldata);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WeatherHomePage(city: exceldata.city)));
      // Map the row data to the model class
      // Map<String, dynamic> rowData = {
      //   'country': row[0]!.value,
      //   'state': row[1]!.value,
      //   'district': row[2]!.value,
      //   'city': row[3]!.value,
      // };

      // return Location.fromMap(rowData);
      print(' hisshsf $sheet\n ${exceldata.country}');
    }

    // setState(() {
    //   // _data = fields;
    // });
  }
}
