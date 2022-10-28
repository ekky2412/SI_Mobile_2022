import 'package:flutter/material.dart';
import 'package:responsi_b/detail_character.dart';
import 'data_source.dart';
import 'helper/shared_preferences.dart';

class ListCharacter extends StatefulWidget {
  const ListCharacter({Key? key}) : super(key: key);

  @override
  _ListCharacterState createState() => _ListCharacterState();
}

class _ListCharacterState extends State<ListCharacter> {
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
          title: Text("List Character"),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: FutureBuilder(
            future: CharacterDataSource.instance.loadCharacters(),
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
        fontSize: 30,
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
          // final _helper = SharedPreferenceHelper();
          // _helper.setCharacter(value);
          return DetailCharacter(name: value);
        }),
      ),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 100,
                child: Image.network(
                    "https://api.genshin.dev/characters/${value}/icon")),
            SizedBox(
              width: 20,
            ),
            TextBesar("${value}".toUpperCase()),
          ],
        ),
      ),
    );
  }
}
