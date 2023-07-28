import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:surf_practice_magic_ball/data/model/answer.dart';

class MagicBallProvider extends StateNotifier<AsyncValue<Answer>> {
  MagicBallProvider() : super(AsyncValue.data(Answer(reading: '')));

  Answer _answerData = Answer(reading: '');

  get getAnswer => _answerData;
  int i = 0;

  Future<void> fetchAnswer() async {
    try {
      state = const AsyncValue.loading();
      // final response = await ApiService().get();

      // if (response == null) return;

      // if (response.statusCode == 200) {
      //   final data = Answer.fromJson(response.body);
      final data = Answer(reading: 'reading$i');
      i += 1;

      _answerData = data;
      if (kDebugMode) {
        print(_answerData.reading);
      }
      // throw false;
      state = AsyncValue.data(_answerData);
      // }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
