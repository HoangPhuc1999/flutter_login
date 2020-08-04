

import 'package:intl/intl.dart';

String convertTime(String format, int time, bool isUTC) {
  return DateFormat(format, 'vi')
      .format(DateTime.fromMillisecondsSinceEpoch(time, isUtc: isUTC));
}

