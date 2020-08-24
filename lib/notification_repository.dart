import 'package:flutterlogin/api_handler.dart';
import 'package:flutterlogin/constant.dart';
import 'package:flutterlogin/entity.dart';



class NotificationRepository{

  Future<List<NotiObject>> getNotification(int page,int count) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.page ] = page;
    body[Constant.count] = count;
    final List<NotiObject> notilist =  <NotiObject>[];

    final AVResponse response =
    await ServerConnection(URL.getnotiurl, body).postData();
    if (response.ok) {
      response.response[Constant.result].forEach((final dynamic itemJson){
          final NotiObject notiObject = NotiObject.fromMap(itemJson as Map<String,dynamic>) ;
          notilist.add(notiObject);
        });
      return notilist;
    } else {
      throw APIException(response);
    }
  }

  Future<void> readNotification(String notificationId) async{
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.notificationId] = notificationId;
    final AVResponse response =
    await ServerConnection(URL.readnotiurl, body).postData();

  }


}