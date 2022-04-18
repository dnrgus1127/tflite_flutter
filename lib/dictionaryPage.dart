//ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pestItem.dart';

class dictionaryPage extends StatelessWidget {
  final List<Pest> pestList;
  const dictionaryPage({Key? key, required this.pestList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Pest List"),
          trailing: CupertinoButton(child: Icon(Icons.exit_to_app), onPressed: (){},),
          leading: CupertinoButton(child: Icon(Icons.arrow_back_ios), onPressed: (){
          },
          ),
        ),
        child: ListView.builder(itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.all(5),
              height: 100,
              child: GestureDetector(
                  
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                            pestList[index].imagePath!,
                            fit: BoxFit.contain,
                            width: 80,
                            height: 80,
                          ),
                          Text(pestList[index].pestName!,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold ),),
                        ],
                      ),
                      Container(
                        height: 2,
                        color: CupertinoColors.black,
                      )
                    ],
                  ),
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('Pest'),
                            content: Text('내용'),
                            actions: [
                              CupertinoButton(
                                  child: Text('확인'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          );
                        });
                  }));
        },
        itemCount: pestList.length,));
  }
}
