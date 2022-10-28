import 'package:flutter/material.dart';
import 'package:responsi_b/detail_character.dart';
import 'package:responsi_b/detail_weapon.dart';
import 'data_source.dart';
import 'helper/shared_preferences.dart';

class ListWeapon extends StatefulWidget {
  const ListWeapon({Key? key}) : super(key: key);

  @override
  _ListWeaponState createState() => _ListWeaponState();
}

class _ListWeaponState extends State<ListWeapon> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("List Weapon"),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: FutureBuilder(
            future: WeaponDataSource.instance.loadWeapons(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                // debugPrint(snapshot.data);
                return _buildErrorSection();
              }
              if (snapshot.hasData) {
                return _buildSuccessSection(snapshot.data);
              }
              return _buildLoadingSection();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildSuccessSection(List<dynamic> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildCityCountries(data[index]);
        });
  }

  Widget TextBesar(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 26,
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildCityCountries(String value) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          final _helper = SharedPreferenceHelper();
          _helper.setWeapon(value);
          return DetailWeapon(name: value);
        }),
      ),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 75,
                child: Image.network(
                    "https://api.genshin.dev/weapons/${value}/icon")),
            SizedBox(
              width: 20,
            ),
            Flexible(child: TextBesar("${value}".toUpperCase())),
          ],
        ),
      ),
    );
  }
}
