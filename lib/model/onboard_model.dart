class OnBoardModel {
  int? _currentPage = 0;
  List<Map<String, String>>? _bodyList = [
    {
      "text": "Welcome to Hermoso, Let’s shop!",
      "image": "assets/images/onboarding0.png"
    },
    {
      "text": "We help people connect with store",
      "image": "assets/images/onboarding1.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/onboarding2.png"
    },
  ];

  List<Map<String, String>>? get bodyList => _bodyList;

  int? get currentPage => _currentPage;

  set currentPage(int? value) {
    _currentPage = value;
  }
}
