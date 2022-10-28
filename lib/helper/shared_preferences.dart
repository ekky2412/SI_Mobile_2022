import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  void setCharacter(String character) async {
    SharedPreferences getPref = await _pref;
    getPref.setString('type', "character");
    getPref.setString('character', character);
  }

  void setWeapon(String weapon) async {
    SharedPreferences getPref = await _pref;
    getPref.setString('type', "weapon");
    getPref.setString('weapon', weapon);
  }

  Future<String> getResult() async {
    SharedPreferences getPref = await _pref;
    String type = getPref.getString('type') ?? "notFound";
    String value = getPref.getString(type) ?? "notFound";
    return value;
  }

  Future<String> getType() async {
    SharedPreferences getPref = await _pref;
    String type = getPref.getString('type') ?? "X";
    return type;
  }

}