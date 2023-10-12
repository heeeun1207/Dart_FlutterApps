//* 미래에 받아올 값을 뜻한다. 
// List 나 Set처럼 제네릭으로 어떤 미래의 값을 받아올지를 정할 수 있다.
// Future<String> name;
// Future<int> number;
// Future<bool> isOpened; //미래에 받을 boolean 값

//비동기 프로그래밍은 서버요청과 같이 오래걸리는 작업은 멈추지 않고 기다린 후 값을 받아와야 하기 때문에
//미래의 값을 표현하는 Future이 필요하다.
//특정 기간동안 아무것도 하지 않고 기다리는 Future.delayed() 가 있다. 

void main () {
  addNumbers(1,1);
}
void addNumbers(int number1, int number2){
  print('$number1 + $number2 계산 시작! ');

  //* Future.delayed() 사용해서 일정 시간 후에 콜백함수를 실행할 수 있음
  Future.delayed(Duration(seconds: 3),(){
    print('$number1 + $number2 = ${number1 + number2 }');
  });
  
  print('$number1 + $number2 코드 실행 끝');
}