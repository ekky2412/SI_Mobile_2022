import 'package:responsi_b/base_network.dart';

class CharacterDataSource {
  static CharacterDataSource instance = CharacterDataSource();
  Future<List<dynamic>> loadCharacters() {
    return BaseNetwork.getList("characters");
  }
}

class WeaponDataSource {
  static WeaponDataSource instance = WeaponDataSource();
  Future<List<dynamic>> loadWeapons() {
    return BaseNetwork.getList("weapons");
  }
}

class CharacterDetailDataSource {
  static CharacterDetailDataSource instance = CharacterDetailDataSource();
  Future<Map<String, dynamic>> loadCharacters(String character) {
    return BaseNetwork.get("characters/${character}");
  }
}

class WeaponDetailDataSource {
  static WeaponDetailDataSource instance = WeaponDetailDataSource();
  Future<Map<String, dynamic>> loadWeapon(String weapon) {
    return BaseNetwork.get("weapons/${weapon}");
  }
}