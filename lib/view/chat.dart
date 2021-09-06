import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:kf_online/modals/data_api.dart';
import 'package:kf_online/modals/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  User user;
  User userTo;

  ChatPage({this.user, this.userTo});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  File _imageFile;
  TextEditingController _content = TextEditingController();
  // Future getImage(ImageSource media) async {
  //   var img = await ImagePicker.pickImage(source: media);
  //   setState(() {
  //     _image = img;
  //   });
  // }
  String username = "", fullName = "", email = "", password = "";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      fullName = preferences.getString("full_name");
      email = preferences.getString("email");
      password = preferences.getString("password");
    });
  }

  _kirimText() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        username = preferences.getString("username");
        fullName = preferences.getString("full_name");
        email = preferences.getString("email");
        password = preferences.getString("password");
      });
      var uri = Uri.parse(BaseUrl.sendMess);

      final request = http.MultipartRequest("POST", uri);

      request.fields['content'] = _content.text;

      request.fields['username'] = preferences.getString("username");
      request.fields['password'] = preferences.getString("password");
      request.fields['user_to'] = widget.userTo.username;

      await request.send();
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  _kirimGambar() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        username = preferences.getString("username");
        fullName = preferences.getString("full_name");
        email = preferences.getString("email");
        password = preferences.getString("password");
      });
      var uri = Uri.parse(BaseUrl.sendMess);
      var stream =
          // ignore: deprecated_member_use
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      final request = http.MultipartRequest("POST", uri);
      var length = await _imageFile.length();
      request.fields['content'] = _content.text;
      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(_imageFile.path)));
      request.fields['username'] = preferences.getString("username");
      request.fields['password'] = preferences.getString("password");
      request.fields['user_to'] = widget.userTo.username;

      await request.send();
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  _kirimpesan() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        username = preferences.getString("username");
        fullName = preferences.getString("full_name");
        email = preferences.getString("email");
        password = preferences.getString("password");
      });
      var uri = Uri.parse(BaseUrl.sendMess);
      var stream =
          // ignore: deprecated_member_use
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      final request = http.MultipartRequest("POST", uri);
      var length = await _imageFile.length();

      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(_imageFile.path)));
      request.fields['content'] = _content.text;
      request.fields['username'] = preferences.getString("username");
      request.fields['password'] = preferences.getString("password");
      request.fields['user_to'] = widget.userTo.username;

      await request.send();
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  // pilihGallery() async {
  //   // ignore: deprecated_member_use
  //   var image = await ImagePicker.pickImage(
  //       source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
  //   setState(() {
  //     _imageFile = image;
  //   });
  // }

  pilihCamera() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
  }

  // void myAlert() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
  //           title: Text('Please choose media to select'),
  //           content: Container(
  //             height: MediaQuery.of(context).size.height / 6,
  //             child: Column(
  //               children: <Widget>[
  //                 TextButton(
  //                   onPressed: () {
  //                     pilihGallery();
  //                   },
  //                   child: Row(
  //                     children: <Widget>[
  //                       Icon(Icons.image),
  //                       Text('From Gallery'),
  //                     ],
  //                   ),
  //                 ),
  //                 TextButton(
  //                   onPressed: () {
  //                     pilihCamera();
  //                   },
  //                   child: Row(
  //                     children: <Widget>[
  //                       Icon(Icons.camera),
  //                       Text('From Camera'),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 120.0,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/asset4.png',
                      fit: BoxFit.contain,
                      height: 20,
                    ),
                    Container(
                        child: Image.asset(
                      'assets/asset5.png',
                      fit: BoxFit.contain,
                      height: 30,
                    ))
                  ],
                ),
              ),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 20.0),
                          child: new IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios_new,
                                  size: 18),
                              color: Colors.teal)),
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            widget.userTo.username,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.teal[800],
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ])
            ],
          ),

          // toolbarHeight: 70.0,
          // title: new Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Image.asset(
          //       'assets/asset1.png',
          //       fit: BoxFit.contain,
          //       height: 50,
          //     ),
          //     Center(child: Text("  Apt.  " + widget.userTo.fullName)),
          //   ],
          // )
        ),
        body: Container(
          child: StreamBuilder(
            initialData: null,
            stream: _stream(),
            builder: (context, snap) {
              if (snap.hasData) {
                var temp = snap.data as Future<List<dynamic>>;
                return Column(
                  children: <Widget>[
                    FutureBuilder(
                      future: temp,
                      builder: (context, snap) {
                        List<dynamic> lst = snap.data;
                        if (lst != null) {
                          return Expanded(
                            child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: lst.length,
                              itemBuilder: (context, index) {
                                var username = lst[index]['user'];
                                var image = lst[index]['image'];
                                var mess = lst[index]['content'].toString();
                                if (image == "") {
                                  return Column(
                                    crossAxisAlignment:
                                        username == widget.user.username
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: username == widget.user.username
                                            ? EdgeInsets.only(
                                                right: 2,
                                                bottom: 5,
                                                top: 5,
                                                left: 100)
                                            : EdgeInsets.only(
                                                right: 100,
                                                bottom: 5,
                                                top: 5,
                                                left: 2),
                                        padding: EdgeInsets.all(13),
                                        child: Text(
                                          mess,
                                          textAlign:
                                              username == widget.user.username
                                                  ? TextAlign.right
                                                  : TextAlign.left,
                                          style: TextStyle(
                                              color: username ==
                                                      widget.user.username
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              username == widget.user.username
                                                  ? Colors.teal[300]
                                                  : Colors.blueGrey[100],
                                          borderRadius: username ==
                                                  widget.user.username
                                              ? BorderRadius.only(
                                                  topLeft: Radius.circular(18),
                                                  bottomLeft:
                                                      Radius.circular(18),
                                                  bottomRight:
                                                      Radius.circular(18),
                                                )
                                              : BorderRadius.only(
                                                  topRight: Radius.circular(18),
                                                  bottomLeft:
                                                      Radius.circular(18),
                                                  bottomRight:
                                                      Radius.circular(18),
                                                ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (mess != "") {
                                  return Column(
                                    crossAxisAlignment:
                                        username == widget.user.username
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: username == widget.user.username
                                            ? EdgeInsets.only(
                                                right: 2,
                                                bottom: 5,
                                                top: 5,
                                                left: 100)
                                            : EdgeInsets.only(
                                                right: 100,
                                                bottom: 5,
                                                top: 5,
                                                left: 2),
                                        padding: EdgeInsets.all(13),
                                        child: Text(
                                          mess,
                                          textAlign:
                                              username == widget.user.username
                                                  ? TextAlign.right
                                                  : TextAlign.left,
                                          style: TextStyle(
                                              color: username ==
                                                      widget.user.username
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              username == widget.user.username
                                                  ? Colors.teal[300]
                                                  : Colors.blueGrey[100],
                                          borderRadius: username ==
                                                  widget.user.username
                                              ? BorderRadius.only(
                                                  topLeft: Radius.circular(18),
                                                  bottomLeft:
                                                      Radius.circular(18),
                                                  bottomRight:
                                                      Radius.circular(18),
                                                )
                                              : BorderRadius.only(
                                                  topRight: Radius.circular(18),
                                                  bottomLeft:
                                                      Radius.circular(18),
                                                  bottomRight:
                                                      Radius.circular(18),
                                                ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          image != null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (_) {
                                                          return DetailScreen(
                                                              image);
                                                        }));
                                                      },
                                                      child: Hero(
                                                        tag: "Image",
                                                        child: Image.network(
                                                            'https://wisatakuapps.com/kf_api/kfonline/upload_mess/' +
                                                                image
                                                                    .toString(),
                                                            height: 180,
                                                            fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      )
                                    ],
                                  );
                                } else {
                                  return Column(
                                    crossAxisAlignment:
                                        username == widget.user.username
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      image != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (_) {
                                                      return DetailScreen(
                                                          image);
                                                    }));
                                                  },
                                                  child: Hero(
                                                    tag: "Image",
                                                    child: Image.network(
                                                        'https://wisatakuapps.com/kf_api/kfonline/upload_mess/' +
                                                            image.toString(),
                                                        height: 180,
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  );
                                }
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 2,
                                      color: Colors.grey)
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.photo_camera,
                                          color: Colors.grey[500]),
                                      onPressed: () {
                                        pilihCamera();
                                      }),
                                  Expanded(
                                    child: TextField(
                                      controller: _content,
                                      decoration: InputDecoration(
                                          hintText: "Tulis Pesan...",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  // IconButton(
                                  //   icon: Icon(Icons.photo_camera),
                                  //   onPressed: () {},
                                  // ),
                                  // IconButton(
                                  //   icon: Icon(Icons.attach_file),
                                  //   onPressed: () {},
                                  // )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.teal, shape: BoxShape.circle),
                            child: IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                if (_content.text != "" && _imageFile != null) {
                                  await _kirimpesan();
                                  _content.text = "";
                                  _imageFile = null;
                                } else if (_content.text != "" &&
                                    _imageFile == null) {
                                  await _kirimText();
                                  _content.text = "";
                                  _imageFile = null;
                                } else if (_content.text == "" &&
                                    _imageFile != null) {
                                  await _kirimGambar();
                                  _content.text = "";
                                  _imageFile = null;
                                }
                                // } else {
                                //   print("empty");
                                // }
                              },
                            ),
                          )
                        ],
                      ),
                    )
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 20.0),
                    //   child: Row(
                    //     children: <Widget>[
                    //       Expanded(
                    //         child: TextField(
                    //             controller: _content,
                    //             decoration: new InputDecoration.collapsed(
                    //                 hintText: "  Tulis Pesan  "),
                    //             style: TextStyle(fontSize: 18.0)),
                    //       ),
                    //       Row(
                    //         children: [
                    //           Container(
                    //             child: IconButton(
                    //                 icon: Icon(
                    //                   Icons.image,
                    //                   color: Colors.teal[300],
                    //                 ),
                    //                 onPressed: () {
                    //                   pilihCamera();
                    //                 }),
                    //           ),
                    //           Container(
                    //             child: IconButton(
                    //                 icon: Icon(
                    //                   Icons.send,
                    //                   color: Colors.teal[300],
                    //                 ),
                    //                 onPressed: () async {
                    //                   String content = _content.text.trim();

                    //                   if (content.isNotEmpty) {
                    //                     var res = await _kirimpesan();
                    //                     print(res);
                    //                     _content.text = "";
                    //                   } else {
                    //                     print("empty");
                    //                   }
                    //                   // ignore: deprecated_member_use
                    //                 }),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Stream<Future<List<dynamic>>> _stream() {
    Duration interval = Duration(seconds: 1);
    Stream<Future<List<dynamic>>> stream =
        Stream<Future<List<dynamic>>>.periodic(interval, _getData);
    return stream;
  }

  Future<List<dynamic>> _getData(int value) async {
    var res = await http.post(BaseUrl.getMess, body: {
      'username': widget.user.username,
      'email': widget.user.email,
      'password': widget.user.password,
      'user_to': widget.userTo.username,
    });
    var jsonx = json.decode(res.body);
    print(widget.user.username);
    print(widget.user.email);
    print(widget.user.password);
    return jsonx;
  }
}

class DetailScreen extends StatelessWidget {
  final String image;
  DetailScreen(this.image);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'Image',
            child: Image.network(
                'https://wisatakuapps.com/kf_api/kfonline/upload_mess/' +
                    image.toString(),
                fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
