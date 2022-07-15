import 'package:hermoso_store/data/local_data/shared_preferences.dart';
import 'package:hermoso_store/model/onBoard/onboard_model.dart';
import 'package:hermoso_store/ui/widgets/dots_container.dart';
import 'package:hermoso_store/ui/widgets/onboard_body.dart';
import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';

import '../widgets/custom_widgets/custom_elevated_button.dart';
import 'auth_Screens/login_screen.dart';

class OnBoardScreen extends StatefulWidget {
  static const routeName = '/onBoard-Screen';

  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final OnBoardModel _onBoardModel = OnBoardModel();
  final PageController _pageController = PageController();
  bool _isDone = false;
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _toLoginScreen() async {
   var onBoards = await SharedPref.saveData(key: 'BoardScreen', value: _isDone);
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    print('onBaordScree save Prefs  is: $onBoards');
  }

  @override
  Widget build(BuildContext context) {
    final bodyList = _onBoardModel.bodyList;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: kWhiteColor,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        value == bodyList.length - 1
                            ? _isDone = true
                            : _isDone = false;
                        _onBoardModel.currentPage = value;
                      });
                    },
                    itemCount: bodyList.length,
                    itemBuilder: (context, index) => OnBoardBody(
                      image: bodyList[index]['image']!,
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
                            currentPage: _onBoardModel.currentPage,
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      CustomElevatedButton(
                        text: _isDone  ?  'Skip' : 'Continue' ,
                        onPress: () {
                          setState(() {
                            _isDone
                                ? _toLoginScreen()
                                : _pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
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
}
