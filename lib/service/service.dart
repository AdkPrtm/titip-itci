import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:titip_itci/models/models.dart';

part 'auth_service.dart';
part 'resi_service.dart';
part 'shared_preferences_service.dart';

String url = 'http://192.168.1.50/';
String inputData = url + 'masukindikit.php';
String getAllData = url + 'semuamuanya.php';
String deleteData = url + 'hapusaku.php';
String editData = url + 'ubahdong.php';
String searchData = url + 'carisatu.php';
String getDataProfit = url + 'hitungdah.php';

Future<String> getToken() async {
  final SharedPreferences _preferences = await SharedPreferences.getInstance();
  var json = _preferences.getString('user');
  if (json != null) {
    UserModel user = UserModel.fromJson(jsonDecode(json));
    return user.token;
  } else {
    return 'kosong';
  }
}

String _getToken() {
  String result = 'kosong po';
  getToken().then((value) {
    result = value;
    return result;
  });
  return result;
}

// String token = await getToken();
String get token => _getToken();

Map<String, String> header = {
  'Content-Type': "application/json",
  "Authorization": token,
};
