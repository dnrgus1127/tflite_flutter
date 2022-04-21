import 'package:fluting/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './constant.dart';
import './HeaderWithSearchBox.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will us total heigth and width of our screen
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(
            title: "Pest Information",
            press: () {},
          ),
          RecomendsPests(),
          TitleWithMoreBtn(
            title: "Lasted Pest",
            press: () {},
          ),
          RecomendsPests(),
          SizedBox(height: kDefaultPadding,)
          

        ],
      ),
    );
  }
}

class RecomendsPests extends StatelessWidget {
  const RecomendsPests({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          RecomendedPestCard(
            image: "repo/images/4.png",
            name: "노린재",
            kinds: "해충",
            press: (){},
          ),
          RecomendedPestCard(
            image: "repo/images/2.jpg",
            name: "카나리",
            kinds: "해충",
            press: (){},
          ),
          RecomendedPestCard(
            image: "repo/images/3.jpg",
            name: "가루이",
            kinds: "해충",
            press: (){},
          ),
          RecomendedPestCard(
            image: "repo/images/5.jpg",
            name: "검거세미나방",
            kinds: "나방",
            press: (){},
          ),
          RecomendedPestCard(
            image: "repo/images/6.jpg",
            name: "도둑나방",
            kinds: "나방",
            press: (){},
          ),
          RecomendedPestCard(
            image: "repo/images/8.jpg",
            name: "배추잎나방",
            kinds: "해충",
            press: (){},
          ),
        ],
      ),
    );
  }
}

class RecomendedPestCard extends StatelessWidget {
  const RecomendedPestCard({
    Key? key,
    this.image,
    this.name,
    this.kinds,
    this.press,
  }) : super(key: key);

  final String? image, name, kinds;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 3,
          bottom: kDefaultPadding * 1.1, 
          ),
      width: size.width * 0.25,
      child: Column(
        children: <Widget>[
          ClipRRect(
            child: Image.asset(
              image!,
              fit: BoxFit.fill,
              width: 150,
              height: 80,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          GestureDetector(
            onTap: () => press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                BoxShadow(
                  offset: Offset(5, 10),
                  blurRadius: 10,
                  color: kPrimaryColor.withOpacity(0.20),
                  
                ),
              ]),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$name\n".toUpperCase(),
                          // style: Theme.of(context).textTheme.button,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: "$kinds",
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key? key,
    this.title,
    this.press,
  }) : super(key: key);

  final String? title;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          TitleWithCustomUnderline(
            text: title,
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () => press,
            child: Text(
              "More",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key? key,
    this.text,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 20),
            child: Text(
              text!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 20),
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
