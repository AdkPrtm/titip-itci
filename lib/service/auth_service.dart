part of 'service.dart';

class AuthService {
  Future<ResultSignIn> signInUser(String email, String password) async {
    try {
      String path = url + 'masukdong.php';
      Map<String, String> header = {'Content-Type': "application/json"};
      var body = jsonEncode({
        'email': email,
        'password': password,
      });

      var response = await http.post(
        Uri.parse(path),
        headers: header,
        body: body,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        UserModel userModel = UserModel.fromJson(data);
        SharedPreferencesService().setUser(userModel);
        return ResultSignIn(userModel: userModel);
      } else {
        return ResultSignIn(
            msg:
                'Upss email dan password nggak cocok nih, coba ingat lagi yaa.');
      }
    } catch (e) {
      return ResultSignIn(
          msg: 'Upss sepertinya server bermasalah, coba dicek lagi yaa.');
    }
  }
}

class ResultSignIn {
  UserModel? userModel;
  String? msg;

  ResultSignIn({this.userModel, this.msg});
}
