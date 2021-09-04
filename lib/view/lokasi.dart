import 'package:flutter/material.dart';

import 'package:kf_online/modals/map_json.dart';
import 'package:kf_online/services/map_services.dart';

class LokasiApotek extends StatefulWidget {
  @override
  _LokasiApotekState createState() => _LokasiApotekState();
}

class _LokasiApotekState extends State<LokasiApotek> {
  List<Lokasi> _lokasi;

  @override
  void initState() {
    super.initState();

    LokasiServices.getLokasi().then((lokasi) {
      setState(() {
        _lokasi = lokasi;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 80.0,
          title: Column(
            children: [
              new Row(
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
              ),
            ],
          ),
        ),
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: ExactAssetImage('assets/asset8.jpeg'),
              fit: BoxFit.fitWidth,
              alignment: new FractionalOffset(0.0, 0.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 220.0),
            child: ListView.builder(
              itemCount: _lokasi == null ? 0 : _lokasi.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.location_on,
                          color: Colors.orange, size: 30.0),
                      title: Text(_lokasi[index].namaApt,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      subtitle: Text(_lokasi[index].alamatApt +
                          "\n" +
                          _lokasi[index].noHp),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
