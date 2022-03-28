class DateFormats {
  String? jsSDate;
  String? phpSDate;
  String? mysQSDate;
  String? jsLDate;
  String? phpLDate;
  String? mysqlLDate;

  DateFormats();

  DateFormats.fromJson(Map<String, dynamic> json) {
    jsSDate = json['js_sdate'];
    phpSDate = json['php_sdate'];
    mysQSDate = json['mysq_sdate'];
    jsLDate = json['js_ldate'];
    phpLDate = json['php_ldate'];
    mysqlLDate = json['mysql_ldate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['js_sdate'] = jsSDate;
    data['php_sdate'] = phpSDate;
    data['mysq_sdate'] = mysQSDate;
    data['js_ldate'] = jsLDate;
    data['php_ldate'] = phpLDate;
    data['mysql_ldate'] = mysqlLDate;
    return data;
  }
}
