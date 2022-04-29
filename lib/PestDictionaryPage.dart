
import 'package:fluting/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'PestInformationPage.dart';
import 'Pest.dart';

class PestDictionaryPage extends StatefulWidget {
  @override
  _PestDictionaryPageState createState() => _PestDictionaryPageState();
}

class _PestDictionaryPageState extends State<PestDictionaryPage> {
  TextEditingController editingController = TextEditingController();

  final List<Pest> pestlist = List.empty(growable: true);
  final List<Pest> list = List.empty(growable: true);
  var items = List.empty(growable: true);
  @override
  void initState() {
    super.initState();
    pestlist.add(Pest(
        name: "검거세미나방",
        targetCrop: "담배, 토마토, 오이, 콩, 감자, 가지 등",
        imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "검거세미나방", targetCrop: "해충", imagePath: "repo/images/2.jpg"));
    pestlist.add(
        Pest(name: "담배가루이", targetCrop: "토마토", imagePath: "repo/images/3.jpg"));
    pestlist.add(
        Pest(name: "먹노린재", targetCrop: "해충", imagePath: "repo/images/4.png"));
    pestlist.add(
        Pest(name: "꽃노랑총채벌레", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "담배거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "담배나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "도둑나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "목화바둑명나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "무잎벌", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "배추좀나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "배추흰나비", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "벼룩잎벌레", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "복숭아혹진딧물", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "비단노린재", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "썩덩나무노린재", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "알락수염노린재", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "열대거세미나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "큰28점박이무당벌레	", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "톱다리개미허리노린재	", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    pestlist.add(
        Pest(name: "파밤나방", targetCrop: "해충", imagePath: "repo/images/1.jpg"));
    items.addAll(pestlist);
    // for(int i=0;i<pestlist.length;i++){
    //   list.add(pestlist[i].name!);
    // }
    //pestlist.sort((a,b) => true ? a.name.compareTo(b.name!) : b.name.compareTo(a.name!));
    //pestlist.sort((a,b) => a.name!.compareTo(b.name!));
  }

  void filterSearchResults (String query){
    List<Pest> dummySearchList = List.empty(growable: true);
    dummySearchList.addAll(pestlist);
    if (query.isNotEmpty) {
      List<Pest> dummyListData = List.empty(growable: true);
      //dummySearchList.forEach((item) {
      dummySearchList.forEach((item) {
      if (item.name!.contains(query)) {
          dummyListData.add(item);
          dummyListData.sort((a,b) => a.name!.compareTo(b.name!));
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(pestlist);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        color: kPrimaryColor,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SearchBox(size: size,editingController: editingController,),
                Container(
                  // SearchBox
                  //alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                      vertical: kDefaultPadding / 2),
                  padding: EdgeInsets.only(left: size.width / 30),
                  height: size.height / 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.38)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                        controller: editingController,
                        decoration: InputDecoration(
                          hintText: "해충 이름 검색",
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(0.8)),
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                      )),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
                //SizedBox(height: 50,),
                Container(
                  height: size.height - 150,
                  //color: Colors.white,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(5, 10),
                            blurRadius: 20,
                            color: Colors.black.withOpacity(0.38))
                      ]),
                  padding: EdgeInsets.only(top: 40,bottom: 20,left: 3),
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PestInfomationPage(
                                  label: items[index].name,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                height: 2,
                                color: kPrimaryColor.withOpacity(0.48),
                              ),
                              //SizedBox(height :40),
                              Row(
                                children: [
                                  Image.asset(
                                    items[index].imagePath!,
                                    fit: BoxFit.fill,
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${items[index].name!}\n",
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: "${items[index].targetCrop}",
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      title: Text(
        "병해충 사전",
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: Icon(CupertinoIcons.back),
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

// class SearchBox extends StatelessWidget {
//   const SearchBox({
//     Key? key,
//     required this.size,
//     required this.editingController,
//   }) : super(key: key);

//   final Size? size;
//   final TextEditingController editingController;
//   @override
//   Widget build(BuildContext context) {
//     return null;
//   }
// }
