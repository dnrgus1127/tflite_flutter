

import 'dart:io';
import 'package:fluting/DisplayPictureScreen.dart';
import 'package:fluting/constant.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCrop extends StatefulWidget {
  final String title;
  File? imageFile;
  ImageCrop({required this.title, this.imageFile});

  @override
  _ImageCrop createState() => _ImageCrop();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _ImageCrop extends State<ImageCrop> {
  AppState? state;
  File? _imageTemp;
  //File? imageFile = widget.imagefile;

  @override
  void initState() {
    super.initState();
    state = AppState.picked;
    _cropImage();
    _imageTemp = widget.imageFile;
    
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40,left: 20,right: 20 ,bottom: 40),
        child: Column(
          children: [

            widget.imageFile != null
                ? ClipRRect(
                    child: Image.file(
                      _imageTemp!,
                      fit: BoxFit.fill,
                      width: 300,
                      height: 300,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  )
                : Container(),
            //SizedBox(height:30),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text("곤충이 위 사각형에 90%이상 꽉차게 맞춰 주세요!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
            ),
            
            Spacer(),
            Row(
              children: [
                CupertinoButton(
                  child: Text("진단"),
                  color: kPrimaryColor,
                  onPressed: () async {
                    await Navigator.push(context, 
                      MaterialPageRoute(builder: (context){
                        return DisplayPictureScreen(
                              imagePath: _imageTemp,
                            );
                          },
                          fullscreenDialog: true),
                    );
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                CupertinoButton(
                  color: kPrimaryColor,
                  child: Text("재조정"),
                  onPressed: () {
                    _cropImage();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: kPrimaryColor,
      //   onPressed: () {
      //     if (state == AppState.free)
      //       _pickImage();
      //     else if (state == AppState.picked)
      //       _cropImage();
      //     else if (state == AppState.cropped) _clearImage();
      //   },
      //   child: _buildButtonIcon(),
      // ),
    );
  }

  // Widget _buildButtonIcon() {
  //   if (state == AppState.free)
  //     return Icon(Icons.add);
  //   else if (state == AppState.picked)
  //     return Icon(Icons.crop);
  //   else if (state == AppState.cropped)
  //     return Icon(Icons.clear);
  //   else
  //     return Container();
  // }

  // Future<Null> _pickImage() async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   _imageTemp = pickedImage != null ? File(pickedImage.path) : null;
  //   if (widget.imageFile != null) {
  //     setState(() {
  //       state = AppState.picked;
  //     });
  //   }
  // }

  Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: widget.imageFile!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: '곤충에 맞게 사진을 지정해주세요!',
            toolbarColor: kPrimaryColor,
            toolbarWidgetColor: Colors.white,
            //statusBarColor: kPrimaryColor,
            backgroundColor: kPrimaryColor,
            activeControlsWidgetColor: kPrimaryColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      _imageTemp = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    widget.imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
}