/// name : "Amos' Bow"
/// type : "Bow"
/// rarity : 5
/// baseAttack : 46
/// subStat : "ATK"
/// passiveName : "Strong-Willed"
/// passiveDesc : "Increases Normal Attack and Aimed Shot DMG by 12/15/18/21/24%. Increases DMG from arrows shot by a further 8/10/12/14/16% for every 0.1s that the arrow is in flight, up to 0.5s. Stacks up to 5 times on each arrow."
/// location : "Gacha"
/// ascensionMaterial : "dandelion"

class WeaponDetailModel {
  WeaponDetailModel({
      String? name, 
      String? type, 
      int? rarity, 
      int? baseAttack, 
      String? subStat, 
      String? passiveName, 
      String? passiveDesc, 
      String? location, 
      String? ascensionMaterial,}){
    _name = name;
    _type = type;
    _rarity = rarity;
    _baseAttack = baseAttack;
    _subStat = subStat;
    _passiveName = passiveName;
    _passiveDesc = passiveDesc;
    _location = location;
    _ascensionMaterial = ascensionMaterial;
}

  WeaponDetailModel.fromJson(dynamic json) {
    _name = json['name'];
    _type = json['type'];
    _rarity = json['rarity'];
    _baseAttack = json['baseAttack'];
    _subStat = json['subStat'];
    _passiveName = json['passiveName'];
    _passiveDesc = json['passiveDesc'];
    _location = json['location'];
    _ascensionMaterial = json['ascensionMaterial'];
  }
  String? _name;
  String? _type;
  int? _rarity;
  int? _baseAttack;
  String? _subStat;
  String? _passiveName;
  String? _passiveDesc;
  String? _location;
  String? _ascensionMaterial;
WeaponDetailModel copyWith({  String? name,
  String? type,
  int? rarity,
  int? baseAttack,
  String? subStat,
  String? passiveName,
  String? passiveDesc,
  String? location,
  String? ascensionMaterial,
}) => WeaponDetailModel(  name: name ?? _name,
  type: type ?? _type,
  rarity: rarity ?? _rarity,
  baseAttack: baseAttack ?? _baseAttack,
  subStat: subStat ?? _subStat,
  passiveName: passiveName ?? _passiveName,
  passiveDesc: passiveDesc ?? _passiveDesc,
  location: location ?? _location,
  ascensionMaterial: ascensionMaterial ?? _ascensionMaterial,
);
  String? get name => _name;
  String? get type => _type;
  int? get rarity => _rarity;
  int? get baseAttack => _baseAttack;
  String? get subStat => _subStat;
  String? get passiveName => _passiveName;
  String? get passiveDesc => _passiveDesc;
  String? get location => _location;
  String? get ascensionMaterial => _ascensionMaterial;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['type'] = _type;
    map['rarity'] = _rarity;
    map['baseAttack'] = _baseAttack;
    map['subStat'] = _subStat;
    map['passiveName'] = _passiveName;
    map['passiveDesc'] = _passiveDesc;
    map['location'] = _location;
    map['ascensionMaterial'] = _ascensionMaterial;
    return map;
  }

}