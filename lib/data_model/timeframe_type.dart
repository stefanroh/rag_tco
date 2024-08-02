enum TimeframeType { second, minute, hour, day, week, month, year }

extension ParseToString on TimeframeType {
  String parseToString() {
    String s =  toString().split('.').last;
     return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }
}
