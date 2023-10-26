import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super (key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea( // 시스템 UI 피해서 UI 그리기
        top: true,
        bottom: false,
        child: Column(
          // 위아래 끝에 각각 위젯 배치하기
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          // 반대축 최대 크기로 늘리기
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay( // _첫글자가 언더스코어이면 다른 파일에서 접근할 수 없다.

              // 하트 눌렀을 때 실행할 함수 전달하기
              onHeartPressed: onHeartPressed,
            ),
            _CoupleImage()
          ],
        ),
      ),
    );
  }


  void onHeartPressed() {   // 하트 눌렀을 때 실행할 함수
    print('클릭');
  }
}



class _DDay extends StatelessWidget {

  // 하트 눌렀을 때 실행할 함수
  final GestureTapCallback onHeartPressed;

  _DDay ({
    required this.onHeartPressed, // 상위에서 함수 입력 받기
});

  @override
  Widget build(BuildContext context){
    // 테마 불러오기
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text( // 최상단의 U&I 텍스트
          'U&I',
          style: textTheme.displayLarge,
        ),
        const SizedBox(height: 16.0),
        Text( // 두 번째 글자
          '우리 처음 만난 날',
          style: textTheme.bodyLarge,
        ),
        Text( // 임의로 지정한 만난 날짜
         '2023.01.01',
         style: textTheme.bodyMedium,
    ),
        const SizedBox(height: 16.0),
        IconButton(
          iconSize: 60.0,
          onPressed:onHeartPressed, // 아이콘 눌렀을 때 실행할 함수
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(// 만난 후 DDay
          'D+365',
          style: textTheme.displayMedium,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Expanded( // Expanded 위젯 - 오버플로 해결 하기
    child : Center(
      child: Image.asset(
      'asset/img/middle_image.png',

      // 화면에 반만큼 높이 구현 -> Expanded 가 우선 순위를 갖게 되어 무시된다.
      height: MediaQuery.of(context).size.height/ 2,
      ),
      ),
    );
  }
}