import 'package:flutter/material.dart';

class ScopeErrorWidget extends StatelessWidget {
  const ScopeErrorWidget({super.key, this.error, this.onRetry});
  final String? error;
  final VoidCallback? onRetry;

  void _retryInitialization(BuildContext context) {
    // Перезапускаем приложение для повторной инициализации
    WidgetsBinding.instance.reassembleApplication();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1A1A2E),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Color(0xFFFF6B6B)),
                const SizedBox(height: 24),
                const Text(
                  'Произошла ошибка',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                if (error != null) ...[
                  Text(
                    error!,
                    style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.7)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                ],
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onRetry ?? () => _retryInitialization(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.refresh, size: 20),
                        SizedBox(width: 8),
                        Text('Попробовать снова', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
