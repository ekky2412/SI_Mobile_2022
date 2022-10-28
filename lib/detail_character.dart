import 'package:flutter/material.dart';
import 'package:responsi_b/data_source.dart';
import 'character_detail_model.dart';


class DetailCharacter extends StatefulWidget {
  final String name;

  const DetailCharacter({Key? key, required this.name}) : super(key: key);

  @override
  _DetailCharacterState createState() => _DetailCharacterState();
}

class _DetailCharacterState extends State<DetailCharacter> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("Detail ${widget.name}".toTitleCase()),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Image.network(
                  "https://api.genshin.dev/characters/${widget.name}/gacha-splash"),
              FutureBuilder(
                future: CharacterDetailDataSource.instance
                    .loadCharacters(widget.name),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    // debugPrint(snapshot.data);
                    return _buildErrorSection();
                  }
                  if (snapshot.hasData) {
                    CharacterDetailModel cityModel = CharacterDetailModel.fromJson(snapshot.data);
                    return _buildSuccessSection(cityModel);
                  }
                  return _buildLoadingSection();
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget TextPutihBesar(String value) {
    return Text(
      value,
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
      ),
    );
  }
  Widget TextPutihSedang(String value) {
    return Text(
      value,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildSuccessSection(CharacterDetailModel data) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network("https://api.genshin.dev/nations/${data.nation!.toLowerCase()}/icon", width: MediaQuery.of(context).size.width/7,),
              Image.network("https://api.genshin.dev/elements/${data.vision!.toLowerCase()}/icon"),
              TextPutihBesar("${widget.name}".toTitleCase()),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 30,
          width: MediaQuery.of(context).size.width/2,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.rarity,
              itemBuilder: (BuildContext context, int index) => Icon(Icons.star, color: Colors.white,),
          ),
        ),
        TextPutihSedang("${data.affiliation}"),
        Container(
          padding: EdgeInsets.all(20),
          child: TextPutihSedang("${data.description}"),
        ),
        _skillTalent(widget.name,data.skillTalents![0], "na"),
        _skillTalent(widget.name,data.skillTalents![1], "skill"),
        _skillTalent(widget.name,data.skillTalents![2], "burst"),
      ],
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _skillTalent(String name,SkillTalents data, String type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.network("https://api.genshin.dev/characters/$name/talent-$type"),
        SizedBox(width: 5,),
        Flexible(child: TextPutihSedang("${data.description}")),
      ],
    );
  }

}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
