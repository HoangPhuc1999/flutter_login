import 'package:flutterlogin/api_handler.dart';
import 'package:flutterlogin/constant.dart';
import 'package:flutterlogin/entity.dart';

class TripRepository {
  Future<List<TripObject>> getTripInfo(String date) async {
    final Map<String, dynamic> map = <String, dynamic>{};
    final List<TripObject> tripobjectlist = <TripObject>[];
    map[Constant.date] = date;

    final AVResponse response =
        await ServerConnection(URL.Routeinfourl, map).postData();
    if (response.ok) {
      final Map<String, dynamic> jsonResult = response.response;
      response.response[Constant.trips].forEach((final dynamic itemJson) {
        final TripObject tripObject =
            TripObject.fromMap(itemJson as Map<String, dynamic>);
        tripobjectlist.add(tripObject);
      });

      return tripobjectlist;
      print('jsonResult $jsonResult');
    } else {
      throw APIException(response);
    }
  }
}
