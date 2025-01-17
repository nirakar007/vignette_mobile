import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignette__mobile/app/di/di.dart';
import 'package:vignette__mobile/features/auth/presentation/view/login_view.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:vignette__mobile/features/home/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit {
  HomeCubit() : super(HomeState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void logout(BuildContext context) {
    // Wait for 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: LoginScreen(),
            ),
          ),
        );
      }
    });
  }
}
