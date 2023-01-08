import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _keywords = ["테슬라", "축구", "아이유", "올림픽"];
  final List<String> _fixedKeywords = [
    "키워드1",
    "키워드2",
    "키워드3",
    "키워드4",
    "키워드5",
    "키워드6"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
          ),
          Container(
            // color: Colors.amberAccent,
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "길동님이 관심있는",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "키워드를 입력해주세요",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "최대 9개까지 입력할 수 있어요",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            // color: Colors.lightGreen,
            margin: const EdgeInsets.only(
              top: 0,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: TextField(
              controller: _textEditingController,
              onSubmitted: _onSubmitted,
              decoration: InputDecoration(
                hintText: "원하는 키워드를 적어보아요",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: GestureDetector(
                  child: const Icon(
                    Icons.cancel,
                    size: 16,
                  ),
                  onTap: () => {_textEditingController.clear()},
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  // flex: 2,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var keyword in _keywords)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 0,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  child: Text(
                                    keyword,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    setState(() {
                                      _keywords.remove(keyword);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    size: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // flex: 1,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var fixedKeyword in _fixedKeywords)
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              if (_keywords.length < 9) {
                                setState(() {
                                  _keywords.add(fixedKeyword);
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECEFF1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                fixedKeyword,
                                style: const TextStyle(
                                  color: Color(0xFF607D8B),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: Container(
              color: _keywords.isEmpty
                  ? const Color(0xFFC5CAE9)
                  : const Color(0xFF3F51B5),
              child: TextButton(
                onPressed: _keywords.isEmpty ? null : () {},
                child: Text(
                  _keywords.isEmpty ? '확인' : '이제 시작해볼까요?',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmitted(String text) {
    setState(() {
      _keywords.add(text);
    });
    _textEditingController.clear();
  }
}
