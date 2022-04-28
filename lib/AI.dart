import 'dart:io';

import 'package:tflite/tflite.dart';

class AiAnal {
  //static String? label;
  //static File? imagePath;
  static List? _outputs;
  AiAnal(
  );

  static Future aiAnal(File? imagePath) async {
    loadModel();
    
    await classifyImage(imagePath!).then((value) => {_outputs = value,Tflite.close()});
    
    return _outputs![0]['label'];
  }

  
  
}

loadModel() async {
    await Tflite.loadModel(
      model: "assets/model96.tflite", labels: "assets/label.txt");
    
  }

Future classifyImage(File image) async {
    print("출력 $image");
    var output = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 10, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );
    return output;
  }