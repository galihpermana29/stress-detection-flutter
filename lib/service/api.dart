import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aplikasi_stress_detection/constants/api.dart';
import 'package:aplikasi_stress_detection/constants/data_schema.dart';
import 'package:aplikasi_stress_detection/constants/file_schema.dart';
import 'package:aplikasi_stress_detection/constants/user_schema.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';

class ApiService {
  Future<User?> getUsers(String idUser) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint + idUser);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        User _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<User?> createUser(String name, String email) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);

      Map<String, dynamic> payload = {
        'name': name,
        'email': email,
      };

      String jsonPayload = jsonEncode(payload);

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonPayload,
      );

      if (response.statusCode == 200) {
        User _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<DataSound?> createData(
      int? user_id, String? sound_uri, String algorithm) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.dataEndpoint);

      Map<String, dynamic> payload = {
        'user_id': user_id,
        'sound_uri': sound_uri,
        'algorithm': algorithm
      };

      String jsonPayload = jsonEncode(payload);

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonPayload,
      );
      print("SENDING ANALYZ:  ${response.body.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        DataSound _model = dataSoundJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<SoundResponse?> uploadFile(File file) async {
    var url = Uri.parse(ApiConstants.baseUrl + 'upload/');
    var request = http.MultipartRequest('POST', url);

    // sound is the key!!
    request.files.add(await http.MultipartFile.fromPath('sound', file.path,
        contentType: MediaType('audio', 'wav')));

    try {
      var response = await request.send();
      var res = await http.Response.fromStream(response);

      if (res.statusCode == 201 || res.statusCode == 200) {
        SoundResponse urlSound = soundFromJson(res.body);
        print("urlSound ${urlSound.toJson()}");
        return urlSound;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
