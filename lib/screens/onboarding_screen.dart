import 'package:egy_news_app/constants/constants.dart';
import 'package:flutter/material.dart';

import 'mainScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }, //to login screen. We will update later
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: PrimaryColor,
                  fontSize: 19.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              CreatePage(
                image: 'assets/images/health.jpg',
                title: Constants.titleOne,
                description: Constants.descriptionOne,
              ),
              CreatePage(
                image: 'assets/images/technology.jpg',
                title: Constants.titleTwo,
                description: Constants.descriptionTwo,
              ),
              CreatePage(
                image: 'assets/images/sports.jpg',
                title: Constants.titleThree,
                description: Constants.descriptionThree,
              ),
              CreatePage(
                image: 'assets/images/business.jpg',
                title: Constants.titleFour,
                description: Constants.descriptionFour,
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children: _buildIndicator(),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color:  PrimaryColor,
              ),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (currentIndex < 3) {
                        currentIndex++;
                        if (currentIndex < 4) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                          );
                        }
                      } else {
                        Navigator.pushReplacement(
                          context,
                            MaterialPageRoute(builder: (_) =>  const HomeScreen(),),);
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 25,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  //Extra Widgets

  //Create the indicator decorations widget
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: isActive ?  PrimaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

//Create the indicator list
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 4; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
class CreatePage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const CreatePage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30.0,
                  ),
                ],),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(image,fit: BoxFit.fill,)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color:  PrimaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
class Constants {
  //primary color

  static var blackColor = Colors.black54;

  //onboardText
  static var titleOne="اخبار الصحة";
  static var descriptionOne="تابع اخبار الصحة في مصر";
  static var titleTwo="اخبار التكنولوجيا";
  static var descriptionTwo="تابع جميع اخبار التكنولوجيا في مصر";
  static var titleThree="اخبار الرياضه";
  static var descriptionThree="تابع اخبار الرياضه في مصر";
  static var titleFour="اخبار العمل";
  static var descriptionFour="تابع جميع اخبار العمل في مصر";

}