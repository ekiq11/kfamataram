// To parse this JSON data, do
//
//     final lokasi = lokasiFromJson(jsonString);

import 'dart:convert';

List<Lokasi> lokasiFromJson(String str) =>
    List<Lokasi>.from(json.decode(str).map((x) => Lokasi.fromJson(x)));

String lokasiToJson(List<Lokasi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Lokasi {
  Lokasi({
    this.idLokasi,
    this.namaApt,
    this.alamatApt,
    this.noHp,
    this.longitude,
    this.latitude,
  });

  String idLokasi;
  String namaApt;
  String alamatApt;
  String noHp;
  String longitude;
  String latitude;

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
        idLokasi: json["id_lokasi"],
        namaApt: json["nama_apt"],
        alamatApt: json["alamat_apt"],
        noHp: json["no_hp"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "id_lokasi": idLokasi,
        "nama_apt": namaApt,
        "alamat_apt": alamatApt,
        "no_hp": noHp,
        "longitude": longitude,
        "latitude": latitude,
      };
}
