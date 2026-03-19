
import 'package:flutter/material.dart';

class ScopeLoaderWidget extends StatelessWidget {
  const ScopeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1A1A2E),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                ),
              ),
              const SizedBox(height: 24),
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: 3),
                duration: const Duration(milliseconds: 900),
                builder: (context, value, child) {
                  return TweenAnimationBuilder<int>(
                    key: ValueKey(DateTime.now().millisecondsSinceEpoch ~/ 900),
                    tween: IntTween(begin: 0, end: 3),
                    duration: const Duration(milliseconds: 900),
                    onEnd: () {},
                    builder: (context, dots, _) {
                      return Text(
                        'Loading${'.' * dots}${' ' * (3 - dots)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.9),
                          letterSpacing: 1.2,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
