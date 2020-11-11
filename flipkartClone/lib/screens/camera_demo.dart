import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//pub.dev - imagePicker
class CameraDemo extends StatefulWidget {
  @override
  _CameraDemoState createState() => _CameraDemoState();
}

class _CameraDemoState extends State<CameraDemo> {
  File imageFile; //from 'dart:io'//for file handling
  _takePic() async {
    /*
     dependency - image_picker
     ImagePicker.pickImage()
     picker.getImage will give a file then we hv to use File from dart:io to read the file

     for the ios we need photo persmission in pslist.file under the <project root>/ios/Runner/Info.plist:
     Android:
     API 29+ - No config needed
     API < 29 
     android:requestLegacyExternalStorage = 'true' to the <application> tag
      UNDER the AndroidManifest.xml <uses-permission android:name='android.permission.CAMERA'

    */
    //depricated
    //ImagePicker.pickImage(source: null); //instead use getImage()

    ImagePicker picker = ImagePicker(); //1st create an object
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.camera); //for picking from gallery use ImageSource.gallery
    //getImage gives the Future<PickedFile>

    //When the photo has been clicked then it is saved inside a file and pickedFile gives a filePath
    String filePath = pickedFile.path;
    imageFile = File(
        filePath); //this will create a File for the path = filePath which is coming from PickedFile which is Future of getImage() of image_picker

    // To display the image from file there is a widget called Image.file()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Camera Demo'),
        ),
        body: Column(
          children: [
            Expanded(
              child: imageFile == null
                  ? Image.network('src')
                  : Container(
                      child: Image.file(imageFile),
                    ),
            ),
            Divider(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                _takePic();
              },
              child: Text('Take Pic'),
            )
          ],
        ));
  }
}
