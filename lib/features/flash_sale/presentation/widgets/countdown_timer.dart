import 'dart:async';

import 'package:flutter/material.dart';

class FlashSaleCountdownTimer extends StatefulWidget {
  const FlashSaleCountdownTimer({
    super.key,
    required this.endAt,
    this.onFinished,
  });

  final DateTime endAt;
  final VoidCallback? onFinished;

  @override
  State<FlashSaleCountdownTimer> createState() =>
      _FlashSaleCountdownTimerState();
}

class _FlashSaleCountdownTimerState extends State<FlashSaleCountdownTimer> {
  Timer? _timer;
  late Duration _remaining;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  @override
  void didUpdateWidget(covariant FlashSaleCountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.endAt != widget.endAt) {
      _finished = false;
      _tick();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_remaining <= Duration.zero) {
      return const Text('Đã kết thúc', key: Key('flash_sale_countdown_done'));
    }
    final hours = _remaining.inHours.toString().padLeft(2, '0');
    final minutes = (_remaining.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_remaining.inSeconds % 60).toString().padLeft(2, '0');
    return Text(
      '$hours:$minutes:$seconds',
      key: const Key('flash_sale_countdown'),
      style: const TextStyle(fontWeight: FontWeight.w800),
    );
  }

  void _tick() {
    final remaining = widget.endAt.difference(DateTime.now());
    if (!mounted) {
      _remaining = remaining;
      return;
    }
    setState(() => _remaining = remaining);
    if (remaining <= Duration.zero && !_finished) {
      _finished = true;
      widget.onFinished?.call();
    }
  }
}
