// //ignore_for_file: prefer_const_constructors

// import "package:camera/camera.dart";
// import 'package:flutter/cupertino.dart';
// import "dart:io";
// import "package:flutter/material.dart";
// import 'package:image_picker/image_picker.dart';

// class CameraExample extends StatefulWidget {
//   final CameraDescription camera;

//   const CameraExample({
//     Key? key,
//     @required this.camera,
//   }) : super(key: key);
//   @override
//   _CameraExampleState createState() => _CameraExampleState();
// }

// class _CameraExampleState extends State<CameraExample> {
//   CameraController _controller;
//   Future<void> _initializeControllerFuture;

//   @override
//   void initState(){
//     super.initState();

//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.medium, // 해상도
//     );

//     _initializeControllerFuture = _controller.initialize();
//   }
//   Future<void> _loadCamera() async {
//     final cameras = await availableCameras();

// // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
//     final firstCamera = cameras.first;

//     TakePictureScreen(camera: firstCamera,);
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return CupertinoPageScaffold(child: TakePictureScreen(camera: firstCamera),);
    
//   }
// }


// class TakePictureScreen extends StatefulWidget {
//   final CameraDescription? camera;

//   const TakePictureScreen({
//     Key? key,
//     @required this.camera,
//   }) : super(key: key);

//   @override
//   TakePictureScreenState createState() => TakePictureScreenState();
// }
// class TakePictureScreenState extends State<TakePictureScreen> {
//   CameraController? _controller;
//   Future<void>? _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     // 카메라의 현재 출력물을 보여주기 위해 CameraController를 생성합니다.
//     _controller = CameraController(
//       // 이용 가능한 카메라 목록에서 특정 카메라를 가져옵니다.
//       widget.camera,
//       // 적용할 해상도를 지정합니다.
//       ResolutionPreset.medium,
//     );

//     // 다음으로 controller를 초기화합니다. 초기화 메서드는 Future를 반환합니다.
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Take a picture')),
//       // 카메라 프리뷰를 보여주기 전에 컨트롤러 초기화를 기다려야 합니다. 컨트롤러 초기화가 
//       // 완료될 때까지 FutureBuilder를 사용하여 로딩 스피너를 보여주세요.
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // Future가 완료되면, 프리뷰를 보여줍니다.
//             return CameraPreview(_controller);
//           } else {
//             // 그렇지 않다면, 진행 표시기를 보여줍니다.
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.camera_alt),
//         // onPressed 콜백을 제공합니다.
//         onPressed: () async {
//           // try / catch 블럭에서 사진을 촬영합니다. 만약 뭔가 잘못된다면 에러에
//           // 대응할 수 있습니다.
//           try {
//             // 카메라 초기화가 완료됐는지 확인합니다.
//             await _initializeControllerFuture;

//             // path 패키지를 사용하여 이미지가 저장될 경로를 지정합니다.
//             final path = join(
//               // 본 예제에서는 임시 디렉토리에 이미지를 저장합니다. `path_provider`
//               // 플러그인을 사용하여 임시 디렉토리를 찾으세요.
//               (await getTemporaryDirectory()).path,
//               '${DateTime.now()}.png',
//             );

//             // 사진 촬영을 시도하고 저장되는 경로를 로그로 남깁니다.
//             await _controller.takePicture(path);

//             // 사진을 촬영하면, 새로운 화면으로 넘어갑니다.
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => DisplayPictureScreen(imagePath: path),
//               ),
//             );
//           } catch (e) {
//             // 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
//             print(e);
//           }
//         },
//       ),
//     );
//   }
// }

// // 사용자가 촬영한 사진을 보여주는 위젯
// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Display the Picture')),
//       // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진 
//       // 경로로 `Image.file`을 생성하세요.
//       body: Image.file(File(imagePath)),
//     );
//   }
// }

// // class CameraExample extends StatefulWidget {
// //   @override
// //   _CameraExampleState createState() => _CameraExampleState();
// // }

// // class _CameraExampleState extends State<CameraExample> {
// //   CameraController? _cameraController;
// //   Future<void>? _initCameraControllerFuture;
// //   int cameraIndex = 0;

// //   bool isCapture = false;
// //   File? captureImage;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initCamera();
// //   }

// //   Future<void> _initCamera() async {
// //     final cameras = await availableCameras();
// //     _cameraController = new CameraController(cameras[cameraIndex], ResolutionPreset.veryHigh);
// //     _initCameraControllerFuture = _cameraController!.initialize().then((value) {
// //       setState(() {});
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _cameraController!.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     Size size = MediaQuery.of(context).size;
// //     return Scaffold(
// //       // appBar: AppBar(
// //       //   title: Text("Camera Example"),
// //       //   centerTitle: true,
// //       // ),
// //       backgroundColor: Colors.black,
// //       body: isCapture
// //           ? Column(
// //               children: [
// //                 /// 촬영 된 이미지 출력
// //                 Flexible(
// //                   flex: 3,
// //                   fit: FlexFit.tight,
// //                   child: Container(
// //                     width: size.width,
// //                     height: size.width,
// //                     child: ClipRect(
// //                       child: FittedBox(
// //                         fit: BoxFit.fitWidth,
// //                         child: SizedBox(
// //                           width: size.width,
// //                           child: AspectRatio(
// //                             aspectRatio: 1 / _cameraController!.value.aspectRatio,
// //                             child: Container(
// //                               width: size.width,
// //                               decoration: BoxDecoration(
// //                                   image: DecorationImage(
// //                                 image: MemoryImage(captureImage!.readAsBytesSync()),
// //                               )),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 Flexible(
// //                   flex: 2,
// //                   fit: FlexFit.tight,
// //                   child: InkWell(
// //                     onTap: () {
// //                       /// 재촬영 선택시 카메라 삭제 및 상태 변경
// //                       captureImage!.delete();
// //                       captureImage = null;
// //                       setState(() {
// //                         isCapture = false;
// //                       });
// //                     },
// //                     child: Container(
// //                       width: double.infinity,
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(
// //                             Icons.arrow_back,
// //                             color: Colors.white,
// //                           ),
// //                           SizedBox(height: 16.0),
// //                           Text(
// //                             "다시 찍기",
// //                             style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             )
// //           : Column(
// //               children: [
// //                 Flexible(
// //                   flex: 3,
// //                   fit: FlexFit.tight,
// //                   child: FutureBuilder<void>(
// //                     future: _initCameraControllerFuture,
// //                     builder: (BuildContext context, AsyncSnapshot snapshot) {
// //                       if (snapshot.connectionState == ConnectionState.done) {
// //                         return SizedBox(
// //                           width: size.width,
// //                           height: size.width,
// //                           child: ClipRect(
// //                             child: FittedBox(
// //                               fit: BoxFit.fitWidth,
// //                               child: SizedBox(
// //                                 width: size.width,
// //                                 child: AspectRatio(aspectRatio: 1 / _cameraController!.value.aspectRatio, child: CameraPreview(_cameraController!)),
// //                               ),
// //                             ),
// //                           ),
// //                         );
// //                       } else {
// //                         return Center(child: CircularProgressIndicator());
// //                       }
// //                     },
// //                   ),
// //                 ),
// //                 Flexible(
// //                   flex: 2,
// //                   child: Container(
// //                     alignment: Alignment.center,
// //                     padding: const EdgeInsets.symmetric(horizontal: 48.0),
// //                     child: Stack(
// //                       alignment: Alignment.center,
// //                       children: [
// //                         GestureDetector(
// //                           onTap: () async {
// //                             try {
// //                               await _cameraController!.takePicture().then((value) {
// //                                 captureImage = File(value.path);
// //                               });

// //                               /// 화면 상태 변경 및 이미지 저장
// //                               setState(() {
// //                                 isCapture = true;
// //                               });
// //                             } catch (e) {
// //                               print("$e");
// //                             }
// //                           },
// //                           child: Container(
// //                             height: 80.0,
// //                             width: 80.0,
// //                             padding: const EdgeInsets.all(1.0),
// //                             decoration: BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               border: Border.all(color: Colors.black, width: 1.0),
// //                               color: Colors.white,
// //                             ),
// //                             child: Container(
// //                               decoration: BoxDecoration(
// //                                 shape: BoxShape.circle,
// //                                 border: Border.all(color: Colors.black, width: 3.0),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         Align(
// //                           alignment: Alignment.centerRight,
// //                           child: IconButton(
// //                             onPressed: () async {
// //                               /// 후면 카메라 <-> 전면 카메라 변경
// //                               cameraIndex = cameraIndex == 0 ? 1 : 0;
// //                               await _initCamera();
// //                             },
// //                             icon: Icon(
// //                               Icons.flip_camera_android,
// //                               color: Colors.white,
// //                               size: 34.0,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //     );
// //   }
// // }




// // class UseCamera extends StatefulWidget{
// //   @override
// //   _useCameraState createState() =>_useCameraState();
// // }

// // class _useCameraState extends State<UseCamera>{
// //   File _image;
// //   final picker =ImagePicker();

// //   Widget build(BuildContext context){
// //     Future getImage(ImageSource imageSource) async {
// //       final pickedFile = await picker.getImage(source: imageSource );

// //       setState(() {
// //         _image = File(pickedFile!.path);
// //       });
// //     }
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             FlatButton(color: Colors.accents[2], onPressed: (){getImage(ImageSource.camera);}, child: Text("Gallery"),),
// //             FlatButton(color: Colors.accents[5], onPressed: (){getImage(ImageSource.gallery);}, child : Text("Camera"),),
// //             showImage(),
// //             ],
// //         ),
// //       ),
// //     );

// //   }
// //   Widget showImage(){
// //     if(_image == null){
// //       return Container();
// //     } else{
// //       return Image.file(_image);
// //     }
// //   }

// // }