import 'package:flutter/material.dart';
import 'dart:io';

import 'package:pic_note/util/db.dart';

class ImageEditor extends StatefulWidget {
  final dynamic image;
  ImageEditor({Key key, this.image}) : super(key: key);
  @override
  _ImageEditorState createState() => new _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  File image;
  DBHelper db;

  _ImageEditorState({File image});

  initDB() async {
    this.db = new DBHelper();
    this.setState(() {});
  }

  _saveImage() async {
    this.db.saveImage(widget.image, 'test');
  }

  @override
  initState() {
    super.initState();
    initDB();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text('Edit'), actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.check),
            onPressed: _saveImage,
          ),
        ]),
        body: new Column(children: [
          widget.image == null ? new Text('...') : new Image.file(widget.image),
          new Padding(
              padding: EdgeInsets.all(20.0),
              child: new TextField(
                decoration: InputDecoration(hintText: 'Description..'),
              ))
        ]));
  }
}
