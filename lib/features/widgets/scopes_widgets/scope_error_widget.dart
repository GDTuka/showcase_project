import 'package:flutter/material.dart';
import 'package:showcase_project/features/widgets/button/app_button.dart';

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
                AppButton.primaryFilled(
                  text: 'Попробовать снова',
                  icon: Icons.refresh,
                  isExpanded: true,
                  onTap: onRetry ?? () => _retryInitialization(context),
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
