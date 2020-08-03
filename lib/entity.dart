import 'package:flutterlogin/constant.dart';
import 'package:json_annotation/json_annotation.dart';


String getString(String key, Map<String, dynamic> data) {
  String result = '';
  if (data == null) {
    result = '';
  } else if (data[key] == null) {
    result = '';
  } else if (!data.containsKey(key)) {
    result = '';
  } else {
    result = data[key].toString();
  }
  return result;
}

///Lấy dữ liệu int từ map mặc định 0
int getInt(String key, Map<String, dynamic> data) {
  int result = 0;
  if (data == null) {
    result = 0;
  } else if (data[key] == null) {
    result = 0;
  } else if (!data.containsKey(key)) {
    result = 0;
  } else {
    result = int.parse(data[key].toString());
  }
  return result;
}

/// Lấy dữ liệu double từ map mặc định 0
double getDouble(String key, Map<String, dynamic> data) {
  double result = 0;
  if (data == null) {
    result = 0;
  } else if (data[key] == null) {
    result = 0;
  } else if (!data.containsKey(key)) {
    result = 0;
  } else {
    result = double.parse(data[key].toString());
  }
  return result;
}

/// lấy dữ liệu bool từ map mặc định false
bool getBool(String key, Map<String, dynamic> data) {
  bool result = false;
  if (data == null) {
    result = false;
  } else if (data[key] == null) {
    result = false;
  } else if (!data.containsKey(key)) {
    result = false;
  } else {
    result = data[key] as bool;
  }
  return result;
}

/// Lấy list double entity
List<double> getListDouble(String key, Map<String, dynamic> data) {
  final List<double> result = <double>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(item as double);
  });
  return result;
}

/// Get list int entity
List<int> getListInt(String key, Map<String, dynamic> data) {
  final List<int> result = <int>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(item as int);
  });
  return result;
}

/// Get list String entity
List<String> getListString(String key, Map<String, dynamic> data) {
  final List<String> result = <String>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(item as String);
  });
  return result;
}

@JsonSerializable(nullable: false)
class NotiObject {
  NotiObject({
    this.notificationId,
    this.notificationContent,
    this.userId,
    this.notificationCode,
    this.createdDate,
    this.objectId,
    this.isRead,
   });

  factory NotiObject.fromMap(final Map<String,dynamic> data){
    if(data == null) {
      return NotiObject();
    }
    return NotiObject(
      notificationId: getString(Constant.notificationId, data),
      notificationContent: getString(Constant.notificationContent, data),
      userId: getString(Constant.userId, data),
      notificationCode: getInt(Constant.notificationCode, data),
      createdDate: getInt(Constant.createDate, data),
      objectId: getString(Constant.objectId, data),
      isRead: getBool(Constant.isRead, data),
    );
  }
  final String notificationId;
  final String notificationContent;
  final String userId;
  final int notificationCode;
  final int createdDate;
  final String objectId;
  final bool isRead;

  NotiObject copyWith({
    String notificationId,
    String notificationContent,
    String userId,
    int notificationCode,
    int createdDate,
    String objectId,
    bool isRead,
  }) {
    if ((notificationId == null ||
            identical(notificationId, this.notificationId)) &&
        (notificationContent == null ||
            identical(notificationContent, this.notificationContent)) &&
        (userId == null || identical(userId, this.userId)) &&
        (notificationCode == null ||
            identical(notificationCode, this.notificationCode)) &&
        (createdDate == null || identical(createdDate, this.createdDate)) &&
        (objectId == null || identical(objectId, this.objectId)) &&
        (isRead == null || identical(isRead, this.isRead))) {
      return this;
    }

    return  NotiObject(
      notificationId: notificationId ?? this.notificationId,
      notificationContent: notificationContent ?? this.notificationContent,
      userId: userId ?? this.userId,
      notificationCode: notificationCode ?? this.notificationCode,
      createdDate: createdDate ?? this.createdDate,
      objectId: objectId ?? this.objectId,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String,dynamic> toJson (){
    return<String,dynamic> {
      Constant.notificationId : notificationId,
      Constant.notificationContent : notificationContent,
      Constant.userId : userId,
      Constant.notificationCode: notificationCode,
      Constant.createdDate : createdDate,
      Constant.objectId : objectId,
      Constant.isRead: isRead,
    };
  }


}




/// parse Point

/// parse Point

// parse list user
