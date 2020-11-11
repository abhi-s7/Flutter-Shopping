import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flipkartClone/db/dbOperations.dart';
import 'package:flipkartClone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadProduct extends StatefulWidget {
  FirebaseApp
      app; //this has to be passed from main Screen as FirebaseStorage requires it as per the new versions
  //this comes from Firebase core
  //because this gets created at the initial stage
  UploadProduct(this.app);
  @override
  _UploadProductState createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  FirebaseStorage fbs;
  //StorageUploadTask uploadTask;:::Depricated

  loadFS() {
    fbs = FirebaseStorage.instanceFor(
        app: widget.app, bucket: 'Your firebase storage path');
    //FirebaseApp.getApp()
    //FirebaseStorage(storageBucket: '');//:::depricated
  }

  _saveRecord() async {
    Product product = Product();
    product.name = _nameCtrl.text;
    product.imagePath = downloadURL;
    product.price = double.parse(_priceCtrl.text);
    product.desc = _descrCtrl.text;

    String result = await DbOperations.addProduct(product);
    //if we don't await it will accept as a future
    //thus await will automatically resolve it in Strign as we have provided Future<String>
    setState(() {
      msg = result;
    });
  }

  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  TextEditingController _descrCtrl = TextEditingController();

  _createTextField(String title, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        hintText: title,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.add),
      ),
    );
  }

  File imageFile;

  _openCameraOrGallery(String name) async {
    ImagePicker imagePicker = ImagePicker(); // it gives a file
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.camera);
    imageFile = File(pickedFile.path);
    print('Image Path is $imageFile');
    setState(() {});
  }

  String imagePath;
  String downloadURL;
  _uploadImage() {
    imagePath =
        'images/${DateTime.now()}'; //this should be unique otherwise the Firebase storage will replace the file
    //Therefore using timestamp
    Reference ref = fbs.ref().child(imagePath);
    //StorageUploadTask has been renamed to UploadTask
    UploadTask uploadTask = ref.putFile(imageFile);
    //this will tell whether the task is successful or not
    //earlier it has methods such as -  onComplete

    uploadTask.then((TaskSnapshot tasksnapshot) async {
      downloadURL = await tasksnapshot.ref.getDownloadURL();
    }).catchError((onError) => setState(() {
          msg = 'Error in Upload $onError';
        }));

    if (uploadTask.snapshot.state == TaskState.success) {
      //String fullPath = uploadTask.;
      setState(() {
        msg = 'File Uploaded $downloadURL';
      });
    } else {
      msg = 'File not uploaded';
    }
  }

  String msg = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadFS();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Upload'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _createTextField('Name of Product', _nameCtrl),
              _createTextField('Product desc', _descrCtrl),
              _createTextField('Product price', _priceCtrl),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      _openCameraOrGallery('');
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      _uploadImage();
                      //calling the method to select the file
                    },
                    child: Text('Upload Image'),
                  ),
                ],
              ),
              RaisedButton(
                onPressed: () {
                  _saveRecord();
                  //calling the method to select the file
                },
                child: Text('Save'),
              ),
              Container(
                width: deviceSize.width,
                height: deviceSize.height / 2,
                child: imageFile == null
                    ? Image.network('')
                    : Image.file(imageFile), //to display the image from File
              )
            ],
          ),
        ));
  }
}
