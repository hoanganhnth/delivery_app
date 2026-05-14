import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;
  final VoidCallback? onFinished;

  const CountdownTimer({
    Key? key,
    required this.endTime,
    this.onFinished,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration _duration;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _calculateDuration();
    _startTimer();
  }

  void _calculateDuration() {
    final now = DateTime.now();
    if (widget.endTime.isAfter(now)) {
      _duration = widget.endTime.difference(now);
    } else {
      _duration = Duration.zero;
      widget.onFinished?.call();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds > 0) {
        setState(() {
          _duration = _duration - const Duration(seconds: 1);
        });
      } else {
        _timer?.cancel();
        widget.onFinished?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildTimeCard(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_duration.inSeconds <= 0) {
      return const Text(
        'Đã kết thúc',
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      );
    }

    final hours = _duration.inHours.toString().padLeft(2, '0');
    final minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_duration.inSeconds % 60).toString().padLeft(2, '0');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTimeCard(hours),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Text(':', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
        ),
        _buildTimeCard(minutes),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Text(':', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
        ),
        _buildTimeCard(seconds),
      ],
    );
  }
}
