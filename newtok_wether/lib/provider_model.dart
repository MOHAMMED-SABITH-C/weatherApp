import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtok_wether/wether_model.dart';

class Location{
  final String country;
  final String state;
  final String district;
  final String city;

  Location({required this.country, required this.state,required this.district,required this.city} );
}

class Detail extends ChangeNotifier{
  final CollectionReference location =FirebaseFirestore.instance.collection('location') ;
  // List<Location> get _location=>loc;
  // List<Location> loc=[];
  void addLocation(Location locat){
    // loc.add(Location(country: locat.country, state: locat.state, district: locat.district, city: locat.city));
    final data={'country':locat.country,'state':locat.state,'district':locat.district,'city':locat.city};

    // location.add(locat);
    location.add(data);
    notifyListeners();
  }

  void updatedetail(Location locat,id){
    // loc[index]=Location(country: locat.country, state: locat.state, district: locat.district, city: locat.city);
    final data={'country':locat.country,'state':locat.state,'district':locat.district,'city':locat.city};
    location.doc(id).update(data);
    notifyListeners();
  }

  void delete(id){
    location.doc(id).delete();
    // loc.removeAt(index);
    notifyListeners();
  }
}

// class weather extends ChangeNotifier{
//   final Welcome weatherdata=Welcome(current: Current(lastUpdatedEpoch: lastUpdatedEpoch, lastUpdated: lastUpdated, tempC: tempC, isDay: isDay, condition: condition, windKph: windKph, humidity: humidity), forecast: );
// } 