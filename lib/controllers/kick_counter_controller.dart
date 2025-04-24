import 'dart:async';
import 'package:get/get.dart';

import '../models/kick_session.dart';

class KickCounterController extends GetxController {
  final isCounting = false.obs;
  final kicks = 0.obs;
  final startTime = Rxn<DateTime>();
  final duration = Duration.zero.obs;
  final journal = <KickSession>[].obs;
  final maxDuration = Duration(hours: 2);

  Timer? timer;

  void startCounting() {
    isCounting.value = true;
    kicks.value = 0;
    startTime.value = DateTime.now();
    duration.value = Duration.zero;
    _startTimer();
  }

  void stopCounting() {
    if (isCounting.value && startTime.value != null) {
      final session = KickSession(
        startTime: startTime.value!,
        duration: duration.value,
        kicks: kicks.value,
      );
      journal.insert(0, session);
    }
    isCounting.value = false;
    kicks.value = 0;
    startTime.value = null;
    duration.value = Duration.zero;
    timer?.cancel();
    timer = null;
  }

  void addKick() {
    if (isCounting.value) kicks.value += 1;
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (!isCounting.value || startTime.value == null) {
        timer?.cancel();
        timer = null;
        return;
      }
      duration.value = DateTime.now().difference(startTime.value!);
      if (duration.value >= maxDuration) {
        stopCounting();
      }
    });
  }

  String getTimeRemaining() {
    if (!isCounting.value) return "02:00:00";
    final left = maxDuration - duration.value;
    return left.toString().split('.').first.padLeft(8, "0");
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
