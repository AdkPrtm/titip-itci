part of 'service.dart';

class ResiService {
  Future<ResultServiceResi> inputResi({
    required String nama,
    required String resi,
    required String posisi,
    required String status,
    required String pembayaran,
    required String hargaCod,
  }) async {
    try {
      final SharedPreferences _preferences =
          await SharedPreferences.getInstance();
      var json = _preferences.getString('user');
      if (json != null) {
        UserModel user = UserModel.fromJson(jsonDecode(json));
        Map<String, String> header = {
          'Content-Type': "application/json",
          "Authorization": user.token,
        };
        var body = jsonEncode({
          'nama': nama,
          'resi': resi,
          'posisi': posisi,
          'status': status,
          'pembayaran': pembayaran,
          'hargaCod': hargaCod,
        });
        var response = await http.post(
          Uri.parse(inputData),
          headers: header,
          body: body,
        );
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body)['message'];
          return ResultServiceResi(msg: data);
        } else {
          return ResultServiceResi(
              msg: 'Upsss, Ada sesuatu yang salah nih coba dicek lagi yaa');
        }
      } else {
        return ResultServiceResi(
            msg: 'Upsss, Ada sesuatu yang salah nih coba dicek lagi yaa');
      }
    } catch (e) {
      return ResultServiceResi(msg: 'Upss mohon dicek dulu servernya ya');
    }
  }

  Future<ResultServiceResi> getResi({
    required int page,
    int rowperpage = 10,
    String? status,
  }) async {
    try {
      var body;
      final SharedPreferences _preferences =
          await SharedPreferences.getInstance();
      var json = _preferences.getString('user');
      if (json != null) {
        UserModel user = UserModel.fromJson(jsonDecode(json));
        Map<String, String> header = {
          'Content-Type': "application/json",
          "Authorization": user.token,
        };
        if (status == null) {
          body = jsonEncode({
            'page': page,
            'rowperpage': rowperpage,
          });
        } else {
          body = jsonEncode({
            'page': page,
            'rowperpage': rowperpage,
            'status': status,
          });
        }
        var response = await http.post(
          Uri.parse(getAllData),
          headers: header,
          body: body,
        );

        if (response.statusCode == 200) {
          List data = jsonDecode(response.body)['data'];
          List<ResiModel> resiData = [];
          for (var resi in data) {
            resiData.add(ResiModel.fromJson(resi));
          }
          return ResultServiceResi(resiModel: resiData);
        } else {
          return ResultServiceResi(
              msg: 'Upss sepertinya ada yang salah, coba login ulang yaa');
        }
      } else {
        return ResultServiceResi(
            msg: 'Upss sepertinya ada yang salah, coba login ulang yaa');
      }
    } catch (e) {
      return ResultServiceResi(
          msg: 'Upss sepertinya ada yang salah, coba servernya lagi yaa');
    }
  }

  Future<String> deleteResi(String resi) async {
    try {
      final SharedPreferences _preferences =
          await SharedPreferences.getInstance();
      var json = _preferences.getString('user');
      if (json != null) {
        UserModel user = UserModel.fromJson(jsonDecode(json));
        Map<String, String> header = {
          'Content-Type': "application/json",
          "Authorization": user.token,
        };
        var body = jsonEncode({'resi': resi});
        var response = await http.post(
          Uri.parse(deleteData),
          headers: header,
          body: body,
        );
        if (response.statusCode == 200) {
          String data = jsonDecode(response.body)['message'];
          return data;
        } else {
          return 'Upss sepertinya ada yang salah, coba di periksa lagi yaa';
        }
      } else {
        return 'Upss sepertinya ada yang salah, coba di periksa lagi yaa';
      }
    } catch (e) {
      return 'Upss sepertinya ada yang salah, coba di periksa lagi yaa';
    }
  }

  Future<String> updatePosisiResi(
      {required String resi, required String posisi}) async {
    try {
      final SharedPreferences _preferences =
          await SharedPreferences.getInstance();
      var json = _preferences.getString('user');
      if (json != null) {
        UserModel user = UserModel.fromJson(jsonDecode(json));
        Map<String, String> header = {
          'Content-Type': "application/json",
          "Authorization": user.token,
        };
        var body = jsonEncode({'resi': resi, 'posisi': posisi});

        var response = await http.post(
          Uri.parse(editData),
          headers: header,
          body: body,
        );
        if (response.statusCode == 200) {
          String data = jsonDecode(response.body)['message'];
          return data;
        } else {
          return 'Upss sepertinya ada yang salah, coba di periksa lagi yaa';
        }
      } else {
        return 'Upss sepertinya ada yang salah, coba di periksa lagi yaa';
      }
    } catch (e) {
      return 'Upss sepertinya ada yang salah, coba di periksa lagi yaa';
    }
  }

  Future<String> updateStatusResi({
    required String resi,
    required String status,
    required int hargaCod,
    required int fee,
  }) async {
    try {
      final SharedPreferences _preferences =
          await SharedPreferences.getInstance();
      var json = _preferences.getString('user');
      if (json != null) {
        UserModel user = UserModel.fromJson(jsonDecode(json));
        Map<String, String> header = {
          'Content-Type': "application/json",
          "Authorization": user.token,
        };

        var body = jsonEncode(
            {'resi': resi, 'status': status, 'hargaCod': hargaCod, 'fee': fee});

        var response = await http.post(
          Uri.parse(editData),
          headers: header,
          body: body,
        );
        if (response.statusCode == 200) {
          String data = jsonDecode(response.body)['message'];
          return data;
        } else {
          return 'Upss sepertinya ada yang salah, coba di periksa lagi yaa';
        }
      } else {
        return 'Upss sepertinya ada yang salah, coba di periksa lagi yaa';
      }
    } catch (e) {
      return 'Upss sepertinya ada yang salah, coba di periksa lagi yaa';
    }
  }

  Future<ResultServiceResi> searchResi({required String resi}) async {
    try {
      final SharedPreferences _preferences =
          await SharedPreferences.getInstance();
      var json = _preferences.getString('user');
      if (json != null) {
        UserModel user = UserModel.fromJson(jsonDecode(json));
        Map<String, String> header = {
          'Content-Type': "application/json",
          "Authorization": user.token,
        };
        var body = jsonEncode({'resi': resi});

        var response = await http.post(
          Uri.parse(searchData),
          headers: header,
          body: body,
        );
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body)['data'][0];
          ResiModel resiModel = ResiModel.fromJson(data);
          return ResultServiceResi(satuResi: resiModel);
        } else {
          return ResultServiceResi(
              msg: 'Data tidak ditemukan, tambahkan data baru');
        }
      } else {
        return ResultServiceResi(
            msg: 'Data tidak ditemukan, tambahkan data baru');
      }
    } catch (e) {
      return ResultServiceResi(msg: 'Upss mohon dicek dulu servernya ya');
    }
  }

  Future<List<String>> getProfit({
    required String tipe,
    required int month,
    required int year,
  }) async {
    try {
      final SharedPreferences _preferences =
          await SharedPreferences.getInstance();
      var json = _preferences.getString('user');
      if (json != null) {
        UserModel user = UserModel.fromJson(jsonDecode(json));
        // return user.token;
        Map<String, String> header = {
          'Content-Type': "application/json",
          "Authorization": user.token,
        };
        var body = jsonEncode({
          'tipe': tipe,
          'month': month,
          'year': year,
        });

        var response = await http.post(
          Uri.parse(getDataProfit),
          headers: header,
          body: body,
        );

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body)['data'];

          return [data['profit'].toString(), data['jumlah_paket'].toString()];
        } else {
          return ['Upss sepertinya ada yang salah, coba login ulang yaa'];
        }
      } else {
        return ['Upss sepertinya ada yang salah, coba login ulang yaa'];
      }
    } catch (e) {
      return ['Upss sepertinya ada yang salah, coba servernya lagi yaa'];
    }
  }
}

class ResultServiceResi {
  List<ResiModel>? resiModel;
  ResiModel? satuResi;
  String? msg;

  ResultServiceResi({this.resiModel, this.msg, this.satuResi});
}
