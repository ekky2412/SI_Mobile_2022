import 'package:flutter/material.dart';
import 'package:responsi_b/data_source.dart';
import 'package:responsi_b/weapon_detail_model.dart';

class DetailWeapon extends StatefulWidget {
  final String name;

  const DetailWeapon({Key? key, required this.name}) : super(key: key);

  @override
  State<DetailWeapon> createState() => _DetailWeaponState();
}

class _DetailWeaponState extends State<DetailWeapon> {
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
                  "https://api.genshin.dev/weapons/${widget.name}/icon"),
              FutureBuilder(
                future: WeaponDetailDataSource.instance
                    .loadWeapon(widget.name),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    // debugPrint(snapshot.data);
                    return _buildErrorSection();
                  }
                  if (snapshot.hasData) {
                    WeaponDetailModel cityModel = WeaponDetailModel.fromJson(snapshot.data);
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

  Widget _buildSuccessSection(WeaponDetailModel data) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
      ],
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
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
