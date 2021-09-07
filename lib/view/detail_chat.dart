import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:kf_online/modals/data_api.dart';
import 'package:kf_online/modals/detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kf_online/view/detail_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

// ignore: must_be_immutable
class DetailChat extends StatefulWidget {
  Chat user;
  Chat userTo;

  DetailChat({this.user, this.userTo});

  @override
  _DetailChatState createState() => _DetailChatState();
}

class _DetailChatState extends State<DetailChat> {
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
      request.fields['user_to'] = widget.userTo.userTo;

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
      request.fields['user_to'] = widget.userTo.userTo;

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
      request.fields['user_to'] = widget.userTo.userTo;

      await request.send();
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  pilihGallery() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
  }

  pilihCamera() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
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
                                  size: 14),
                              color: Colors.teal)),
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            widget.userTo.userTo,
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
                              controller: _scrollController,
                              itemCount: lst.length + 1,
                              itemBuilder: (context, index) {
                                if (index == lst.length) {
                                  return Container(height: 70.0);
                                }

                                var username = lst[index]['user'];
                                var image = lst[index]['image'];
                                var mess = lst[index]['content'].toString();

                                if (image == "") {
                                  return Column(
                                    crossAxisAlignment:
                                        username == widget.user.userFrom
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: username == widget.user.userFrom
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
                                              username == widget.user.userFrom
                                                  ? TextAlign.right
                                                  : TextAlign.left,
                                          style: TextStyle(
                                              color: username ==
                                                      widget.user.userFrom
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              username == widget.user.userFrom
                                                  ? Colors.teal[300]
                                                  : Colors.blueGrey[100],
                                          borderRadius: username ==
                                                  widget.user.userFrom
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
                                        username == widget.user.userFrom
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: username == widget.user.userFrom
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
                                              username == widget.user.userFrom
                                                  ? TextAlign.right
                                                  : TextAlign.left,
                                          style: TextStyle(
                                              color: username ==
                                                      widget.user.userFrom
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              username == widget.user.userFrom
                                                  ? Colors.teal[300]
                                                  : Colors.blueGrey[100],
                                          borderRadius: username ==
                                                  widget.user.userFrom
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
                                                        tag: lst[index]
                                                            ['image'],
                                                        child: Image.network(
                                                            'http://kfonline.aksestryout.com/akses/upload_mess/' +
                                                                lst[index][
                                                                        'image']
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
                                        username == widget.user.userFrom
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
                                                    tag: lst[index]['image'],
                                                    child: Image.network(
                                                        'http://kfonline.aksestryout.com/akses/upload_mess/' +
                                                            lst[index]['image']
                                                                .toString(),
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
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: TextField(
                                        onTap: () {
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeOut);
                                        },
                                        controller: _content,
                                        decoration: InputDecoration(
                                            hintText: "Tulis Pesan...",
                                            border: InputBorder.none),
                                      ),
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
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeOut);
                                  _content.text = "";
                                  _imageFile = null;
                                } else if (_content.text != "" &&
                                    _imageFile == null) {
                                  await _kirimText();
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeOut);
                                  _content.text = "";
                                  _imageFile = null;
                                } else if (_content.text == "" &&
                                    _imageFile != null) {
                                  await _kirimGambar();
                                  _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeOut);
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
      'username': widget.user.userFrom,
      'email': '$email',
      'password': '$password',
      'user_to': widget.userTo.userTo,
    });
    var jsonx = json.decode(res.body);
    // print(widget.user.userFrom);
    // print('$email');
    // print('$password');
    return jsonx;
  }
}
