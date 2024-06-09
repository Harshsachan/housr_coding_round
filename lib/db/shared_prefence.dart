import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _keyUsername = 'username';
  static const _keyEmail = 'email';

  static Future<void> saveUser(String username, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyEmail, email);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyEmail);
  }


  static Future<void> addIdToEmail(int id, String email) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(email);
    if (ids == null) {
      await prefs.setStringList(email, [id.toString()]);
    } else {
      ids.add(id.toString());
      await prefs.setStringList(email, ids);
    }
  }

  static Future<List<int>> getIdsForEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(email);
    if (ids == null) return [];
    return ids.map((e) => int.parse(e)).toList();
  }

  static Future<void> clearIdsForEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(email);
  }


}
