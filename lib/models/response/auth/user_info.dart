import 'dart:convert';
import 'dart:typed_data';

import 'package:posdelivery/models/constants.dart';

class UserInfo {
  String? address;
  String? department;
  String? email;
  String? empFullName;
  String? empID;
  String? empName;
  String? extension;
  String? mobile;
  String? position;
  String? userName;
  String? profilePic;
  UserInfo();

  String get profileBlob {
    String str = profilePic ?? '';
    return str.replaceAll(Constants.dataImageTypeBase64, Constants.none);
  }

  Uint8List get profileImage {
    return base64Decode(profileBlob);
  }

  UserInfo.fromJSON(Map<String, dynamic> parsedJson) {
    address = parsedJson['Address'];
    department = parsedJson['Department'];
    email = parsedJson['Email'];
    empFullName = parsedJson['EmpFullName'];
    empID = parsedJson['EmpID'];
    empName = parsedJson['EmpName'];
    extension = parsedJson['Extension'];
    mobile = parsedJson['Mobile'];
    position = parsedJson['Position'];
    userName = parsedJson['UserName'];
    profilePic = parsedJson['ProfilePic'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': address,
        'department': department,
        'email': email,
        'empFullName': empFullName,
        'empID': empID,
        'empName': empName,
        'extension': extension,
        'mobile': mobile,
        'position': position,
        'userName': userName,
        'profilePic': profilePic,
      };
}
