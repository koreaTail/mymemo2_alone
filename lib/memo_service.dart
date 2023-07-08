import 'dart:convert';

import 'package:flutter/material.dart';

import 'main.dart';

// 메모 데이터 형식 정해주기
class Memo {
  Memo({
    required this.content,
  });

  String content;

  Map toJson() {
    return {'content': content};
  }

  factory Memo.fromJson(json) {
    return Memo(content: json['content']);
  }
}

// 메모 데이터는 모두 여기서 관리
class MemoService extends ChangeNotifier {
  MemoService() {
    loadMemoList();
  }

  List<Memo> memoList = [];

  createMemo({required String content}) {
    Memo memo = Memo(content: content);
    memoList.add(memo);
    notifyListeners();
    saveMemoList();
  }

  updateMemo({required int index, required String content}) {
    Memo memo = memoList[index];
    memo.content = content;
    notifyListeners();
    saveMemoList();
  }

  deleteMemo({required int index}) {
    memoList.removeAt(index);
    notifyListeners();
    saveMemoList();
  }

  saveMemoList() {
    List memoJsonList = memoList.map((memo) => memo.toJson()).toList();

    String jsonString = jsonEncode(memoJsonList);

    prefs.setString('memoList', jsonString);
  }

  loadMemoList() {
    String? jsonString = prefs.getString('memoList');

    if (jsonString == null) return;

    List memoJsonList = jsonDecode(jsonString);

    memoList = memoJsonList.map((json) => Memo.fromJson(json)).toList();
  }
}
