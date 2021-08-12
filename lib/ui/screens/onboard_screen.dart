import 'package:firstdesign/data/local_data/shared_preferences.dart';
import 'package:firstdesign/model/onboard_model.dart';
import 'package:firstdesign/ui/widgets/custom_elevated_button.dart';
import 'package:firstdesign/ui/widgets/dots_container.dart';
import 'package:firstdesign/ui/widgets/onboard_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_Screens/login_screen.dart';

class OnBoardScreen extends StatefulWidget {
  static const routeName = '/onBoard-Screen';

  const OnBoardScreen();

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final OnBoardModel? _onBoardModel = OnBoardModel();
  PageController _pageController = PageController();
  bool _isDone = false;

  @override
  Widget build(BuildContext context) {
    final bodyList = _onBoardModel!.bodyList;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0,right: 20.0,left: 20.0),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        value == bodyList!.length - 1
                            ? _isDone = true
                            : _isDone = false;
                        _onBoardModel!.currentPage = value;
                      });
                    },
                    itemCount: bodyList!.length,
                    itemBuilder: (context, index) => OnBoardBody(
                      image: bodyList[index]['image'] ??
                          'assets/images/onboarding0.png',
                      text: bodyList[index]['text'] ??
                          'Welcome to Hermoso, Let’s shop!',
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          bodyList.length,
                          (index) => DotsContainer(
                            index: index,
                            currentPage: _onBoardModel!.currentPage,
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      CustomElevatedButton(
                        text: 'Continue',
                        onPress: () {
                          setState(() {
                            _isDone
                                ? _toLoginScreen()
                                : _pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.fastLinearToSlowEaseIn);
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toLoginScreen() async {
  await SharedPref.saveData(key: 'BoardScreen', value: true);
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}
