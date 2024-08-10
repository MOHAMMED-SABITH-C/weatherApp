// import 'dart:js_interop';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
// import 'package:newtok_wether/login.dart';
// import 'package:newtok_wether/main.dart';
import 'package:newtok_wether/provider_model.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
  double mheight =MediaQuery.of(context).size.height;
   double mwidth =MediaQuery.of(context).size.width; 
    return Consumer<Detail>(
      builder: (context,locations,child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(actions: [IconButton(onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil('/Admin', (route)=>false);
        // Navigator.pushNamedAndRemoveUntil(context, '/Admin',(Route<dynamic> route)=>false);

            }, icon: Icon(Icons.logout_sharp))],
            title: Text('Locations',style: TextStyle(
                color: Color(0xF704357F),
                fontWeight: FontWeight.bold,
                fontSize: 35),),
                centerTitle: true,
            ),
            body: StreamBuilder(
              stream: locations.location.snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    // itemCount: locations.loc.length,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder:(context,index){
                        final data=snapshot.data!.docs[index];
                        return Card(
                                  elevation: 50,
                                  color: Color.fromARGB(255, 37, 219, 210),
                                  shape: BeveledRectangleBorder( borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    leading: Container(
                                      decoration: BoxDecoration(color: Color.fromARGB(255, 0, 0, 0).withAlpha(200),
                                      // backgroundBlendMode: BlendMode.color,
                                      borderRadius:BorderRadius.all(Radius.circular(8)) ),
                                      height: mheight*0.2,
                                      width: mwidth*0.2,
                                      alignment: Alignment.center,
                                      child:Text('${data['city']}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10,),textAlign: TextAlign.center,)
                                       ),
                  
                                       title: Text(data['country']),
                                       isThreeLine: true,
                                       subtitle: Text('State : ${data['state']}\nDistrict : ${data['district']}\nCity : ${data['city']}') ,
                                       trailing: //IconButton(onPressed: (){
                                        FocusedMenuHolder(
                                          menuWidth: mwidth*0.4,
                                          openWithTap: true,
                                          onPressed: (){
                          
                                          },
                                          child: Icon(Icons.more_vert_outlined,color: Colors.black,),
                                          menuItems: [
                                              FocusedMenuItem(title: Text('Edit'),
                                               onPressed: (){
                                                  showAdd(context,data['country'],data['state'],data['district'],data['city'],data.id);
                
                                                // showDField(data.id,data.classId,data.subjId, mheight, mwidth);
                                               },
                                               trailingIcon: Icon(Icons.edit)
                                               ),
                                              FocusedMenuItem(backgroundColor: Colors.red,
                                              title: Text('Delete',style: TextStyle(color: Colors.white),),
                                               onPressed: (){
                                                locations.delete(data.id);
                                                // deleS(data.id,data.classId, data.subjId);
                                              } ,
                                              trailingIcon:Icon(Icons.delete,color: Colors.white,) ,),
                                          ],
                                          )
                                      //  }, icon:Icon(Icons.more_vert_outlined,color: Colors.black,)
                                      )
                                       ,
                                );
                            
                          
                        }
                        ),
                );
                }else return SizedBox(height: 10,);
              }
            ),
                  //  separatorBuilder:((context, index) {
                  //    return Divider(thickness: 5,color:Colors.transparent ,);
                  //  }),
                  //   itemCount: subjects.length
                    // );
              
          //   },),
          // ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton.icon(
          //       onPressed: (){
          // showBottomSheet(context, mwidth,widget.classId);

          //       },
          //        icon: Icon(Icons.add),
          //         label: Text('Add Subjects'),
          //         style:ButtonStyle( 
          //           shape:MaterialStateProperty.all(
          //             RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(20)
          //             )
          //           )
          //         )
          //         ),
                // return Container(
                //   child: Card(
                //     elevation: 10,
                //     borderOnForeground: false,
                //     child: Column(
                //       children: [
                //         Text('Country : ${data.country}',style: TextStyle(fontWeight: FontWeight.bold),),
                //         Text('State : ${data.state}'),
                //         Text('District : ${data.district}'),
                //         Text('City : ${data.city}'),

                //       ],
                //     ),
                //   )
                // );
              // } 
              // ),
              floatingActionButton: FloatingActionButton(onPressed: (){
                  showAdd(context,'','','','',-1);

              },
              child: Icon(Icons.add,color: Colors.black,),
              ),
            ),
        );
      }
    );
  }
  Future showAdd(BuildContext context,country,state,district,city,flag) async{
    
    final TextEditingController _country=TextEditingController();
    final TextEditingController _state=TextEditingController();
    final TextEditingController _district=TextEditingController();
    final TextEditingController _city=TextEditingController();
    _country.text=country;
    _state.text=state;
    _district.text=district;
    _city.text=city;
    // showModalBottomSheet(
    showDialog(
      context: context,
      builder:((context){
        return AlertDialog(
          title: Text('Add location'),
          content: Padding(
            padding:EdgeInsets.only(top:15,right: 18,left: 18),
            child: Container(
              height: 260,
              width: 100,
              child: ListView(
                children: [
                  TextField(
                    controller: _country,
                    decoration: InputDecoration(
                      hintText: 'Country',
                      label: Text('Country'),
                      border: InputBorder.none
                    ),
                  ),
                  TextField(
                    controller: _state,
                    decoration: InputDecoration(
                      hintText: 'State',
                      label: Text('State'),
                      border: InputBorder.none
                    ),
                  ),
                  TextField(
                    controller: _district,
                    decoration: InputDecoration(
                      hintText: 'District',
                      label: Text('District'),
                      border: InputBorder.none
                    ),
                  ),
                  TextField(
                    controller: _city,
                    decoration: InputDecoration(
                      hintText: 'City',
                      label: Text('City'),
                      border: InputBorder.none
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {
                      final country=_country.text.trim();
                      final state=_state.text.trim();
                      final district=_district.text.trim();
                      final city=_city.text.trim();
                      flag==-1?Provider.of<Detail>(context,listen:false).addLocation(Location(country: country, state: state, district: district, city: city))
                      :Provider.of<Detail>(context,listen:false).updatedetail(Location(country: country, state: state, district: district, city: city),flag);
                      
                      setState(() {
                      _country.text='';
                        _state.text='';
                        _district.text='';
                        _city.text='';
                      });
                      Navigator.of(context).pop();
                    },
                    child: flag==-1?Text('Add'):Text('Update'),
                    ),
                  )
                ],
              ),
            ), 
            ),
        );
      })

    );
  }
}