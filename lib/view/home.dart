import 'package:kf_online/view/botton_buttons.dart';
import 'package:kf_online/view/explanation.dart';
import 'package:flutter/material.dart';
import 'package:kf_online/view/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<ExplanationData> data = [
  ExplanationData(
      description:
          "Aplikasi yang memudahkan anda konsultasi obat dengan Apotek Kimia Farma secara online.",
      title: "Klik KF",
      subtitle: "Komunikasi Online Apoteker",
      localImageSrc: "assets/asset1.png"),
  ExplanationData(
      description: "Dapatkan informasi dan konsultasi obat secara gratis.",
      title: "Klik KF",
      subtitle: "Komunikasi Online Apoteker",
      localImageSrc: "assets/asset2.png"),
  ExplanationData(
      description:
          "Konsultasi dan informasi obat kapan saja  selama 24 jam sehari.",
      title: "Klik KF",
      subtitle: "Komunikasi Online Apoteker",
      localImageSrc: "assets/asset3.jpg"),
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> /*with ChangeNotifier*/ {
  final _controller = PageController();

  int _currentIndex = 0;

  String username;
  String fullName;
  String email;
  String password;

  savePref(String username, String fullName, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("username", username);
      preferences.setString("full_name", fullName);
      preferences.setString("email", email);
      preferences.setString("password", password);
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      fullName = preferences.getString("fullName");
      email = preferences.getString("email");
      password = preferences.getString("password");
      if (username != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Profile();
            },
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    print(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 80.0,
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/asset4.png',
                  fit: BoxFit.contain,
                  height: 20,
                ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/asset5.png',
                      fit: BoxFit.contain,
                      height: 30,
                    ))
              ],
            )),
        body: Container(
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(16),
              color: data[_currentIndex].backgroundColor,
              alignment: Alignment.center,
              child: Column(children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: PageView(
                                  scrollDirection: Axis.horizontal,
                                  controller: _controller,
                                  onPageChanged: (value) {
                                    // _painter.changeIndex(value);
                                    setState(() {
                                      _currentIndex = value;
                                    });
                                    // notifyListeners();
                                  },
                                  children: data
                                      .map((e) => ExplanationPage(data: e))
                                      .toList())),
                          flex: 4),
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(data.length,
                                        (index) => createCircle(index: index)),
                                  )),
                              BottomButtons(
                                currentIndex: _currentIndex,
                                dataLength: data.length,
                                controller: _controller,
                              )
                            ],
                          ))
                    ],
                  ),
                )
              ]),
            )));
  }

  createCircle({int index}) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        margin: EdgeInsets.only(right: 4),
        height: 5,
        width: _currentIndex == index ? 15 : 5,
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(3)));
  }
}
