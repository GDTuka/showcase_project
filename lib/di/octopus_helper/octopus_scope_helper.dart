import 'package:flutter/material.dart';
import 'package:padi/padi.dart';
import 'package:showcase_project/di/scopes/auth_scope.dart';
import 'package:showcase_project/di/scopes/user_scope.dart';
import 'package:showcase_project/di/scopes/habit_scope.dart';
import 'package:showcase_project/features/widgets/scopes_widgets/scope_error_widget.dart';
import 'package:showcase_project/features/widgets/scopes_widgets/scope_loader_widget.dart';

class ScopeHelper {
  factory ScopeHelper() => _instance;
  static final ScopeHelper _instance = ScopeHelper._internal();
  static ScopeHelper get instance => _instance;

  ScopeHelper._internal();

  AuthScope? authScope;
  UserScope? userScope;
  HabitScope? habitScope;
}

class AuthScopeWrapper extends StatelessWidget {
  const AuthScopeWrapper({super.key, required this.child});

  final Widget child;

  void onCreated(AuthScope scope) {
    ScopeHelper().authScope = scope;
  }

  @override
  Widget build(BuildContext context) {
    final cached = ScopeHelper().authScope;
    if (cached != null) {
      return PadiScope(padi: cached, child: child);
    }
    return PadiWidget<AuthScope>(
      create: AuthScope.new,
      loaderBuilder: (_) => ScopeLoaderWidget(),
      errorBuilder: (context) => ScopeErrorWidget(),
      onCreated: onCreated,
      child: child,
    );
  }
}

class UserScopeWrapper extends StatelessWidget {
  const UserScopeWrapper({super.key, required this.child});

  final Widget child;

  void onCreated(UserScope scope) {
    ScopeHelper().userScope = scope;
  }

  @override
  Widget build(BuildContext context) {
    final cached = ScopeHelper().userScope;
    if (cached != null) {
      return PadiScope(padi: cached, child: child);
    }
    return PadiWidget<UserScope>(
      create: UserScope.new,
      loaderBuilder: (_) => ScopeLoaderWidget(),
      errorBuilder: (context) => ScopeErrorWidget(),
      onCreated: onCreated,
      child: child,
    );
  }
}

class HabitScopeWrapper extends StatelessWidget {
  const HabitScopeWrapper({super.key, required this.child});

  final Widget child;

  void onCreated(HabitScope scope) {
    ScopeHelper().habitScope = scope;
  }

  @override
  Widget build(BuildContext context) {
    final cached = ScopeHelper().habitScope;
    if (cached != null) {
      return PadiScope(padi: cached, child: child);
    }
    return PadiWidget<HabitScope>(
      create: HabitScope.new,
      loaderBuilder: (_) => ScopeLoaderWidget(),
      errorBuilder: (context) => ScopeErrorWidget(),
      onCreated: onCreated,
      child: child,
    );
  }
}
