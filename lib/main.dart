import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  // 필수적
  runApp(const MyApp()); //MyApp을 실행하자
}

class MyApp extends StatelessWidget {
  //변함없음
  const MyApp({super.key}); //이것도 무조건 하는듯.. 다른 앱과 비교 필요

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //오른쪽 상단에 디버그표시 없애줌
      home: HomePage(), //메인페이지 실행?
    );
  }
}

class HomePage extends StatelessWidget {
  //변함없음
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mymemo_alone"), //상단 중앙 글씨
      ),
      body: Center(
        //바디 중앙에 단일
        child: Text("메모를 작성해주세요"),
      ),
      floatingActionButton: FloatingActionButton(
          //오른쪽 하단에 버튼
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailPage()), //디테일페이지로 이동
            );
          }),
    );
  }
}

class DetailPage extends StatelessWidget {
  //디테일페이지는 뒤로가기 기능이 기본제공됨
  DetailPage({super.key});

  TextEditingController contentController = TextEditingController(); //아직 기능 모름

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //오른쪽 상단
          IconButton(
            onPressed: () {
              //삭제 버튼 클릭 시 할 행동
            },
            icon: Icon(Icons.delete), //쓰레기통
          )
        ],
      ),
      body: TextField(
        //글쓰기 모드
        controller: contentController, //삭제해도 동작하네.
        decoration: InputDecoration(
          hintText: "메모를 입력하세요",
          border: InputBorder.none,
        ),
        autofocus: true, //접근하자마자 글씨 수정이 바로 가능하게 됨
        maxLines: null, // null로 설정하면 줄 수가 무한으로 늘어남. 기본값은 1줄
        expands: true, //부모을 따라 커짐. 가능한 한 가장 큰 범위에서 놀게 함, 꺼도 차이 없는 듯?
        keyboardType: TextInputType.multiline, // 뭔지 모르겠음. 있으나 없으나 같음
        onChanged: (value) {
          // 텍스트필트 안의 값이 변할 때 저장하기!!!
        },
      ),
    );
  }
}
