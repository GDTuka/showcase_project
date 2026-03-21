import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';
import 'package:showcase_project/features/navigation/router.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  Routes _selectedRoute = Routes.home;

  void _onNavBarTap(Routes route) {
    if (_selectedRoute == route) {
      return;
    }

    setState(() {
      _selectedRoute = route;
    });
    context.octopus.setArguments(
      (args) => args
        ..clear()
        ..addAll({"activePage": route.name}),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: colorScheme.shadow.withAlpha(26), blurRadius: 24, offset: const Offset(0, 10))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.home_rounded, 'Home', Routes.home),
          _buildNavItem(context, Icons.add_circle_rounded, 'Add', Routes.addHabbit),
          _buildNavItem(context, Icons.person_rounded, 'Profile', Routes.profile),
          _buildNavItem(context, Icons.settings_rounded, 'Settings', Routes.settings),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, Routes route) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = _selectedRoute == route;

    return Expanded(
      child: AnimatedScale(
        scale: isSelected ? 1.0 : 0.96,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.primary.withAlpha(28) : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _onNavBarTap(route),
              borderRadius: BorderRadius.circular(22),
              splashFactory: InkSparkle.splashFactory,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected ? colorScheme.primary : colorScheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        size: 22,
                        color: isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                      child: Text(label),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
