part of 'service.dart';

class SharedPreferencesService {
  Future setUser(UserModel userModel) async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    final json = jsonEncode(userModel);
    return await _preferences.setString('user', json);
  }
  
  Future removeUser() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    return await _preferences.remove('user');
  }
}
