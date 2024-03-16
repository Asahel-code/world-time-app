import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time = "";
  String flag;
  String url;
  bool isDaytime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try {
      var link =
      Uri.https('worldtimeapi.org', '/api/timezone/$url');

      // Fetch data
      Response response = await get(link);
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //   create a DateTime Object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 19 ? true : false;
      // Set time property
      time = DateFormat.jm().format(now);
    }
    catch(e){
      time = "Could not get time data";
    }

  }
}