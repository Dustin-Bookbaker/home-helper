import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Bloc/user/user_bloc.dart';
import 'package:homehelper/Common/constants/routing_constants.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class ProfilePicturePage extends StatefulWidget {
  @override
  _ProfilePicturePageState createState() => _ProfilePicturePageState();
}

class _ProfilePicturePageState extends State<ProfilePicturePage> {
  File _image;
  String _uploadedFileURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, homeProfileRoute),
        ),
        title: Text('Profilbild hochladen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Ausgewähltes Bild'),
            _image != null
                ? Image.asset(
                    _image.path,
                    height: 150,
                    width: 150,
                    scale: 1,
                  )
                : Container(height: 150),
            _image == null
                ? RaisedButton(
                    child: Text('Datei auswählen'),
                    onPressed: chooseFile,
                    color: Colors.lightGreen[400],
                  )
                : Container(),
            _image != null
                ? RaisedButton(
                    child: Text('Datei hochladen'),
                    onPressed: uploadFile,
                    color: Colors.cyan,
                  )
                : Container(),
            _image != null
                ? RaisedButton(
                    child: Text('Auswahl entfernen'),
                    onPressed: () {
                      setState(() {
                        _image.deleteSync();
                      });
                    },
                  )
                : Container(),
            Text('Hochgeladenes Bild'),
            _uploadedFileURL != null
                ? Image.network(
                    _uploadedFileURL,
                    height: 150,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('userImages/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        BlocProvider.of<UserBloc>(context).add(UserImageEvent(image: fileURL));
      });
    });
  }
}
