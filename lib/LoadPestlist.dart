import 'dart:convert';

import 'package:fluting/Pest.dart';
import 'package:flutter/services.dart';

class LoadPestlist {
  List<Pest> pestlist = List.empty(growable: true);
  List data = List.empty(growable: true);
  
  List<Pest> getPestlist()  {
    
     this.loadJsonData().then(
      (value) {
        for (var i in data) {
          pestlist.add(
            Pest(
              name: i['name'],
              targetCrop: i['target'],
              imagePath: "repo/images/" + i['name'] + ".jpg",
              solution: i['solution'],
              shape: i['shape'],
              damage: i['damage'],
            ),
          );
        }
      }
    );
    return pestlist;
  }
   Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/pest.json');
    data = json.decode(jsonText);
    return 'success';
  }
}