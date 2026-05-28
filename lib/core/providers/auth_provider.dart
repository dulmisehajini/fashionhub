import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';

// ApiService provider — like a React context
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// Auth state
class AuthState {
  final bool isLoggedIn;
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? user;

  AuthState({
    this.isLoggedIn = false,
    this.isLoading = false,
    this.error,
    this.user,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    String? error,
    Map<String, dynamic>? user,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
    );
  }
}

// Auth notifier — like a React reducer
class AuthNotifier extends StateNotifier<AuthState> {
  final ApiService _apiService;

  AuthNotifier(this._apiService) : super(AuthState()) {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final loggedIn = await _apiService.isLoggedIn();
    state = state.copyWith(isLoggedIn: loggedIn);
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await _apiService.login(
        email: email,
        password: password,
      );
      state = state.copyWith(
        isLoggedIn: true,
        isLoading: false,
        user: data['user'],
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await _apiService.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      state = state.copyWith(
        isLoggedIn: true,
        isLoading: false,
        user: data['user'],
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _apiService.logout();
    state = AuthState();
  }
}

// The provider Flutter uses
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(apiServiceProvider)),
);

// Products provider
final productsProvider = FutureProvider.family<List<dynamic>, String?>(
  (ref, category) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getProducts(category: category);
  },
);