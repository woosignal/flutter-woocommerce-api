import 'package:http/http.dart' as http;
import 'dart:convert';

class SchoolMessage {
  List<Records> records;

  SchoolMessage({this.records});

  SchoolMessage.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = new List<Records>();
      json['records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  String id;
  String contact;
  String message;
  String flag;

  Records({this.id, this.contact, this.message, this.flag});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contact = json['Contact'];
    message = json['Message'];
    flag = json['Flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Contact'] = this.contact;
    data['Message'] = this.message;
    data['Flag'] = this.flag;
    return data;
  }

  Future getMessages(String schoolNameId) async {
    try {
      String url =
          'https://rpi.t4top.com/api/message.php?school_name_id=$schoolNameId';
      final response = await http.post(
        url,
      );
      final responseData = json.decode(response.body);
      print(
        json.decode(response.body),
      );
      print(
          'This is the Response I am getting ${responseData['records'][0]['Contact']}');

      return responseData;
    } catch (error) {
      throw error;
    }
  }
}
