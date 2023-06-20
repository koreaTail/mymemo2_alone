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

class HomePage extends StatefulWidget {
  //변함없음
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> memoList = [
    '장보기 목록: 사과, 양파sdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfawsefawefasefwsesdfsdfsdfsdfsdfsdfawsefawefasefwsesdfsdfsdfsdfsdfsdfawsefawefasefwsesdfsdfsdfsdfsdfsdfawsefawefasefwseasefasefaewsf',
    '유튜브 찍기'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mymemo_alone"), //상단 중앙 글씨
      ),
      body: memoList.isEmpty
          ? Center(child: Text("메모를 작성해 주소서"))
          : ListView.builder(
              itemCount: memoList.length,
              itemBuilder: (context, index) {
                String memo = memoList[index];
                return ListTile(
                  leading: IconButton(
                    icon: Icon(CupertinoIcons.pin),
                    onPressed: () {
                      print('$memo : pin 클릭 됨');
                    },
                  ),
                  title: Text(
                    memo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // ...을 통해 생략된 부분 표시
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          index: index,
                          memoList: memoList,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        //오른쪽 하단에 버튼
        child: Icon(Icons.add),
        onPressed: () {
          String memo = '';
          setState(() {
            memoList.add(memo);
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                index: memoList.indexOf(memo),
                memoList: memoList,
              ),
            ), //디테일페이지로 이동
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  //디테일페이지는 뒤로가기 기능이 기본제공됨
  DetailPage({super.key, required this.memoList, required this.index});

  final List<String> memoList;
  final int index;

  TextEditingController contentController = TextEditingController(); //아직 기능 모름

  @override
  Widget build(BuildContext context) {
    contentController.text = memoList[index];

    return Scaffold(
      appBar: AppBar(
        actions: [
          //오른쪽 상단
          IconButton(
            onPressed: () {
              //삭제 버튼 클릭 시 할 행동
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("정말로 삭제하시겠습니까?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("취소"),
                      ),
                      // 확인
                      TextButton(
                        onPressed: () {
                          memoList.removeAt(index);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "확인",
                          style: TextStyle(color: Colors.pink),
                        ),
                      )
                    ],
                  );
                },
              );
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
          memoList[index] = value;
        },
      ),
    );
  }
}
