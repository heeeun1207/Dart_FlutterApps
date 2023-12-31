import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';
import 'package:shake/shake.dart';

// BottomNavigationBar 아래에 배치하고,
// 남는 공간에 TabBarView 위치시켜서 스크린 전환이 가능한 구조로 구현한다.

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with
TickerProviderStateMixin {
  // TickerProviderStateMixin 사용하기
  TabController? controller; // 사용할 탭 컨트롤러 선언
  double threshold= 2.7; // 민감도의 기본값 설정
  int number = 1; // 주사위 숫자
  ShakeDetector? shakeDetector;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this); // 컨트롤러 초기화하기
    // 컨트롤러 속성이 변경될 때마다 실행할 함수 등록하기
    controller!.addListener(tabListener);

    shakeDetector = ShakeDetector.autoStart( // 1. 흔들기 감지 즉시 시작
      shakeSlopTimeMS: 100, // 2. 감지 주기
      shakeThresholdGravity: threshold, // 3. 감지 민감도
      onPhoneShake: onPhoneShake, // 4. 감지 후 실행할 함수
    );
  }
  void onPhoneShake(){ // 5. 감지 후 실행할 함수
    final rand = new Random(); // dart:math 기본제공하는 Random 클래스 사용

    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }

  tabListener(){  // 리스너로 사용할 함수
    setState(() {});
  }

  @override
  dispose(){
    controller!.removeListener(tabListener); // 리스너에 등록한 함수 취소
    shakeDetector!.stopListening(); // 6. 흔들기 감지 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView( // 앱 화면을 보여줄 위젯
        controller: controller, // ! 컨트롤러 등록하기
        children: renderChildren(),
      ),
      // 아래 탭 내비게이션을 구현하는 매개변수
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      // Container의 Text 삭제하고 number값 1 입력해서 임시로 보여주기
      HomeScreen(number: number), // 임의 1 -> number 변수로 대체
      SettingsSreen( // 기존에 있던 Container 코드 SettingsSreen 교체
          threshold: threshold,
          onThresholdChange: onThresholdChange,
      ),
    ];
  }
  // 슬라이더값 변경 시 실행 함수
  void onThresholdChange(double val){
    setState(() {
      threshold =val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    // 탭 내비게이션을 구현하는 위젯
    return BottomNavigationBar(
      // 현재 화면에 렌더링되는 탭의 인덱스
      currentIndex: controller!.index,
      onTap: (int index){ // 탭이 선택될때마다 실행되는 함수
        setState(() {
          controller!.animateTo(index);
        });
      },

      items: [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.edgesensor_high_outlined,
        ),
        label: '주사위',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
        label: '설정',
      ),
    ],
    );
  }
}

// TabController 에서 vsync 기능을 사용하려면 필수로 TickerProviderStateMixin 사용해야 한다.
// TickerProviderStateMixin 와 SingleTickerProviderStateMixin 애니메이션 효율을 올려주는 역할을 한다.
// TabController의 length의 매개변수에 탭 개수를 int로 제공하고,
// vsync에는 TickerProviderMixin 을 사용하는 State 클래스를 this 형태로 넣는다.
// 결과 : 그렇게 해서 생성된 TabController는 TabBarView의 매개변수에 입력한다.
// 즉 입력된 controller를 통해서 TabBarView를 조작할 수 있음.


// 정리 : 이해하고 넘어가기
// TabBarView는 TabController가 필수이다.
// 추가적으로 TabController를 초기화하려면 vsync 기능이 필요한데 이는 State 위젯에
// TickerProviderMixin 을 mixin으로 제공해줘야 사용할 수 있다