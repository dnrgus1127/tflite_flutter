import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fluting/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import './main.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  
  CameraController _cameraController =
      CameraController(cameras![0], ResolutionPreset.medium,);
  PageController _pageController =
      PageController(initialPage: 1, viewportFraction: 0.2);
  int _selectedTab = 1;

  @override
  void initState() {
    super.initState();

    _cameraController.initialize().then((_) {
      if (!mounted) return;

      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          _buildCameraBar(context),
          Spacer(),
          if (_cameraController.value.isInitialized)
            //_buildCameraPreview(context),
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height / 8,
              child: _buildCameraSelector(context),
            )
        ],
      ),
    );
  }

  Widget _buildCameraBar(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    final deviceRatio = devicesize.width / devicesize.height;
    final TextStyle style = Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold);

    return Container(
      //height: MediaQuery.of(context).size.height / 8,
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 8,
      //height: 120,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform.scale(
            //scale: _cameraController.value.aspectRatio / deviceRatio,
            scale: 1.5,
            alignment: Alignment.center,
            child: CameraPreview(_cameraController),
            //aspectRatio: _cameraController.value.aspectRatio,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding + 10,
                  left: kDefaultPadding / 2,
                  right: kDefaultPadding / 2,
                ),
                child: Row(
                  // 상단 NavBar

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // X 버튼
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    //SizedBox(width: 1,),
                    Container(
                      // 작물 촬영 Text
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Icon(
                              CupertinoIcons.ant,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                          Text(
                            "작물 촬영!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // help Icon
                      height: 90,
                      //height: MediaQuery.of(context).size.height / 3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildIconWithText(
                                context,
                                Icon(
                                  CupertinoIcons.question_circle,
                                  color: Colors.white,
                                ),
                                "Help",
                                style,
                                20),
                            // _buildIconWithText(
                            // context,
                            // Icon(
                            //   CupertinoIcons.star_fill,
                            //   color: Colors.white,
                            // ),
                            // "BM",
                            // style,
                            // 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              _buildCameraTypeSelector(context),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildIconWithText(
                        context,
                        Icon(
                          CupertinoIcons.app_badge_fill,
                          color: Colors.white,
                        ),
                        "text",
                        style.copyWith(fontSize: 11),
                        35),
                    InkWell(
                      onTap: () async {
                        XFile? rawImage = await takePicture();
                        File imageFile = File(rawImage!.path);

                        int currentUnix = DateTime.now().millisecondsSinceEpoch;
                        final directory =
                            await getApplicationDocumentsDirectory();
                        String fileFormat = imageFile.path.split('.').last;

                        await imageFile.copy(
                          '${directory.path}/$currentUnix.$fileFormat',
                        );
                        //print(imageFile.toString());

                        Navigator.pop(context,imageFile);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         DisplayPictureScreen(imagePath: imageFile),
                                
                        //   ),
                        // );
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: _buildIconWithText(
                          context,
                          Icon(
                            CupertinoIcons.refresh,
                            color: Colors.white,
                          ),
                          "text",
                          style.copyWith(fontSize: 11),
                          35),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future<XFile?> takePicture() async {
  final CameraController? cameraController = _cameraController;
  if (cameraController!.value.isTakingPicture) {
    // A capture is already pending, do nothing.
    return null;
  }
  try {
    XFile file = await cameraController.takePicture();
    return file;
  } on CameraException catch (e) {
    print('Error occured while taking picture: $e');
    return null;
  }
}

  Widget _buildCameraTypeSelector(BuildContext context) {
    final List<String> cameratTypes = ["Photo", "Video"];

    TextStyle style = Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 65,
          height: 25,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(50)),
        ),
        Container(
          height: 45,
          child: PageView.builder(
            // onPageChanged: (int page) => {
            //   setState((){
            //     _selectedTab = page;
            //   })
            // },
            controller: _pageController,
            itemCount: cameratTypes.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                child: Text(
                  cameratTypes[0],
                  //cameratTypes[index],
                  style: style.copyWith(color: Colors.white),
                ),
              );
            },
          ),
        ),
        // Container(
        //   width: 50,
        //   height: 45,
        //   alignment: Alignment.bottomCenter,
        //   child: CircleAvatar(backgroundColor: Colors.white,radius: 2.5,),
        // )
      ],
    );
  }

  Widget _buildIconWithText(BuildContext context, Icon icon, String text,
      TextStyle style, double size) {
    return Column(
      children: <Widget>[
        icon,
        //Icon(CupertinoIcons.star_fill,color: Colors.yellow,),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: style,
        )
      ],
    );
  }

  Widget _buildCameraSelector(BuildContext context) {
    final List<String> postTypes = ["Quick", "Camera", "Templates"];

    TextStyle style = Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold);
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 45,
          child: PageView.builder(
            onPageChanged: (int page) => {
              setState(() {
                _selectedTab = page;
              })
            },
            controller: _pageController,
            itemCount: postTypes.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                child: Text(
                  postTypes[index],
                  style: style.copyWith(
                      color:
                          _selectedTab == index ? Colors.white : Colors.grey),
                ),
              );
            },
          ),
        ),
        Container(
          width: 50,
          height: 45,
          alignment: Alignment.bottomCenter,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 2.5,
          ),
        )
      ],
    );
  }
}




  // Widget _buildCameraPreview(BuildContext context) {
  //   final TextStyle style = Theme.of(context).textTheme.bodyText1!.copyWith(
  //       fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold);

  //   return Container(
  //     color: Colors.red,
  //     //height: MediaQuery.of(context).size.height - 190,
  //     //height: MediaQuery.of(context).size.height -  ((MediaQuery.of(context).size.height / 8) + 70),

  //     height: MediaQuery.of(context).size.height -
  //         MediaQuery.of(context).size.height / 8 -
  //         120,

  //     child: Column(
  //       children: <Widget>[
  //         //Spacer(),
  //         Transform.scale(
  //           scale: 1 /
  //               (_cameraController.value.aspectRatio *
  //                   MediaQuery.of(context).size.aspectRatio),
  //           alignment: Alignment.topCenter,
  //           child: CameraPreview(
  //             _cameraController,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: <Widget>[
  //                 _buildCameraTypeSelector(context),
  //                 SizedBox(
  //                   height: 5,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(bottom: 10),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: <Widget>[
  //                       _buildIconWithText(
  //                           context,
  //                           Icon(
  //                             CupertinoIcons.app_badge_fill,
  //                             color: Colors.white,
  //                           ),
  //                           "text",
  //                           style.copyWith(fontSize: 11),
  //                           35),
  //                       Container(
  //                         padding: EdgeInsets.all(4),
  //                         decoration: BoxDecoration(
  //                           border: Border.all(color: Colors.white),
  //                           borderRadius: BorderRadius.circular(50),
  //                         ),
  //                         child: CircleAvatar(
  //                           backgroundColor: Colors.white,
  //                           radius: 25,
  //                         ),
  //                       ),
  //                       _buildIconWithText(
  //                           context,
  //                           Icon(
  //                             CupertinoIcons.app_badge_fill,
  //                             color: Colors.white,
  //                           ),
  //                           "text",
  //                           style.copyWith(fontSize: 11),
  //                           35),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  
