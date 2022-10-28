import 'package:flutter/material.dart';
import 'package:responsi_b/detail_weapon.dart';
import 'package:responsi_b/helper/shared_preferences.dart';
import 'package:responsi_b/list_weapon.dart';
import 'detail_character.dart';
import 'list_character.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                image: NetworkImage(
                    "https://4.bp.blogspot.com/-iz7Z_jLPL6E/XQ8eHVZTlnI/AAAAAAAAHtA/rDn9sYH174ovD4rbxsC8RSBeanFvfy75QCKgBGAs/w1440-h2560-c/genshin-impact-characters-uhdpaper.com-4K-2.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image(image: AssetImage('assets/genshin_impact_logo.png')),
            _kotakSharedPref(),
            Container(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListCharacter()))
                          .then((value) => setState(() {}));
                    },
                    child: Text("Karakter"),
                    style: ElevatedButton.styleFrom(minimumSize: Size(200, 50)),
                  ),
                  SizedBox(
                    child: Text(""),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListWeapon()))
                            .then((value) => setState(() {}));
                      },
                      child: Text("Weapon"),
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(200, 50)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() { });
    }
  }

  Widget _kotakSharedPref() {
    final _helper = SharedPreferenceHelper();
    // Disini ngecek kalo ada isinya type (character / weapon), ntar keluarin sesuai typenya
    return FutureBuilder(
      future: _helper.getType(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot1) {
        return FutureBuilder(
          future: _helper.getResult(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
            debugPrint("Type - ${snapshot1.data}");
            debugPrint("Chara - ${snapshot2.data}");
            if (snapshot1.data == "character") {
              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailCharacter(name: snapshot2.data))),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 100,
                          child: Image.network(
                              "https://api.genshin.dev/characters/${snapshot2.data}/icon")),
                      SizedBox(
                        width: 20,
                      ),
                      TextBesar("${snapshot2.data}".toUpperCase()),
                    ],
                  ),
                ),
              );
            } else if (snapshot1.data == "weapon") {
              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailWeapon(name: snapshot2.data))),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 75,
                          child: Image.network(
                              "https://api.genshin.dev/weapons/${snapshot2.data}/icon")),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(child: TextBesar("${snapshot2.data}".toUpperCase())),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox(width: 0);
            }
          },
        );
      },
    );
  }

  Widget TextBesar(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 26,
      ),
    );
  }
}
