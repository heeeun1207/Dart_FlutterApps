// 머터리얼 디자인과 관련된 기능을 불러오는 코드
// material.dart 파일을 불러와야
// 플러터에서 제공하는 기본 위젯을 사용할 수 있다.
import 'package:flutter/material.dart';

void main (){
  runApp(
      MaterialApp( // 머터리얼 디자인 위젯
        home:Scaffold( // Scaffold 위젯
          body:Center(
            child: Text(
              'Hello World',
          ),
        ),
      ),
   ),
);
}