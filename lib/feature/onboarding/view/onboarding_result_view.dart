import 'package:flutter/material.dart';

class OnboardingResultView extends StatefulWidget {
  const OnboardingResultView({Key? key}) : super(key: key);

  @override
  State<OnboardingResultView> createState() => _OnboardingResultViewState();
}

class _OnboardingResultViewState extends State<OnboardingResultView> {
  final List<String> _selectedKeywords = [
    "테슬라",
    "축구",
    "올림픽",
    "플러터",
    "구글",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Container(
              color: const Color(0xFF263238),
            ),
          ),
          Column(
            children: [
              Container(
                height: 56,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "흥미로운 키워드에요",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
              ),
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var keyword in _selectedKeywords)
                            Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
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
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Container(
                  color: const Color(0xFF3F51B5),
                  child: TextButton(
                    onPressed: () {},
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
}
