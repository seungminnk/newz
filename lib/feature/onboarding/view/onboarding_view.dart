import 'package:flutter/material.dart';

import 'package:newz/feature/onboarding/view/onboarding_result_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _enteredKeywords = ["테슬라", "축구", "아이유", "올림픽"];
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
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "키워드를 입력해주세요",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "최대 9개까지 입력할 수 있어요",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.only(
              top: 0,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: TextField(
              controller: _textEditingController,
              textAlignVertical: TextAlignVertical.center,
              onSubmitted: _onEnteredKeyword,
              style: const TextStyle(
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: "원하는 키워드를 적어보아요",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: GestureDetector(
                  child: const Icon(
                    Icons.cancel,
                    size: 14,
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
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var keyword in _enteredKeywords)
                          _generateEnteredKeywordTag(keyword)
                      ],
                    ),
                  ),
                ),
                Expanded(
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
                          _generateFixedKeywordTag(fixedKeyword)
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
              color: _enteredKeywords.isEmpty
                  ? const Color(0xFFC5CAE9)
                  : const Color(0xFF3F51B5),
              child: TextButton(
                onPressed: _enteredKeywords.isEmpty ? null : _onTabNextButton,
                child: Text(
                  _enteredKeywords.isEmpty ? '확인' : '이제 시작해볼까요?',
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

  void _onEnteredKeyword(String text) {
    setState(() {
      _enteredKeywords.add(text);
    });
    _textEditingController.clear();
  }

  Widget _generateEnteredKeywordTag(String enteredKeyword) {
    return Container(
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
              left: 16,
              right: 4,
              top: 9,
              bottom: 9,
            ),
            child: Text(
              enteredKeyword,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                _enteredKeywords.remove(enteredKeyword);
              });
            },
            icon: const Icon(
              Icons.cancel_outlined,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _generateFixedKeywordTag(String fixedKeyword) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (_enteredKeywords.length < 9) {
          setState(() {
            _enteredKeywords.add(fixedKeyword);
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 11,
          bottom: 11,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFECEFF1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          fixedKeyword,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF607D8B),
          ),
        ),
      ),
    );
  }

  void _onTabNextButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OnboardingResultView(
          enteredKeywords: _enteredKeywords,
        ),
      ),
    );
  }
}
