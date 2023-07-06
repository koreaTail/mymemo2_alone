import 'package:flutter/material.dart';

import 'main.dart';

// 메모 데이터 형식 정해주기
class Memo {
  Memo({
    required this.content,
  });

  String content;
}

// 메모 데이터는 모두 여기서 관리
class MemoService extends ChangeNotifier {
  List<Memo> memoList = [
    Memo(content: '장보기 목록: 딸기, 포도'),
    Memo(content: '세 매모2'),
  ];

  createMemo({required String content}) {
    Memo memo = Memo(content: content);
    memoList.add(memo);
    notifyListeners();
  }

  updateMemo({required int index, required String content}) {
    Memo memo = memoList[index];
    memo.content = content;
    notifyListeners();
  }

  deleteMemo({required int index}) {
    memoList.removeAt(index);
    notifyListeners();
  }
}
