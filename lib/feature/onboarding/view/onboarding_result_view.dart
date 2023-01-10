import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OnboardingResultView extends StatefulWidget {
  final List<String> enteredKeywords;

  const OnboardingResultView({
    Key? key,
    required this.enteredKeywords,
  }) : super(key: key);

  @override
  State<OnboardingResultView> createState() => _OnboardingResultViewState();
}

class _OnboardingResultViewState extends State<OnboardingResultView> {
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.33,
            child: Container(
              color: const Color(0xFF263238),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 56,
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Column(
                children: const [
                  Text(
                    "흥미로운 키워드에요",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "키워드를 토대로",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "기사를 요약해드릴게요!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Expanded(
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 12,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          children: [
                            for (var keyword in widget.enteredKeywords)
                              _generateEnteredKeywordTag(keyword),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Container(
                  color: const Color(0xFF3F51B5),
                  child: TextButton(
                    onPressed: () {
                      int userId = 1;
                      String requestUrl =
                          "http://localhost:3001/api/user/keyword";
                      Response response = dio.post(requestUrl, data: {
                        'user_id': userId,
                        'keywords': widget.enteredKeywords
                      }) as Response;

                      if (response.statusCode == 200) {
                        // onboarding complete flag true로 변경하기
                      } else {
                        // 에러 리턴
                      }
                    },
                    child: const Text(
                      '이제 시작해볼까요?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _generateEnteredKeywordTag(String keyword) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
        bottom: 10,
      ),
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF3F51B5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        keyword,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }

  _onClickStartBtn(List<String> enteredKeywords) async {
    int userId = 1;

    String requestUrl = "http://localhost:3001/api/user/keyword";

    Response response = await dio.post(requestUrl,
        data: {'user_id': userId, 'keywords': enteredKeywords});

    if (response.statusCode == 200) {
      // onboarding complete flag true로 변경하기
    } else {
      // 에러 리턴
    }
  }
}
