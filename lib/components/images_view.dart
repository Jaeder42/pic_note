import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:pic_note/views/image_editor.dart';
import '../util/db.dart';

class ImagesView extends StatefulWidget {
  ImagesView({Key key}) : super(key: key);
  @override
  _ImagesViewState createState() => new _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  dynamic db;
  List<dynamic> images = [];

  intiDB() async {
    this.db = new DBHelper();
    this.images = await this.db.getImages();
    this.setState(() {});
  }

  picker(context) async {
    print('Picker is called');
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // if (img != null) {
    //   image = img;
    //   setState(() {});
    // }
    if (img != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImageEditor(image: img)),
      );
    }
  }

  @override
  initState() {
    super.initState();
    intiDB();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: this.images.length > 0 ? new Text('Full') : new Text('Empty'),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => picker(context),
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
