import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignette__mobile/app/di/di.dart';
import 'package:vignette__mobile/features/auth/presentation/view/registration_view.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:vignette__mobile/features/board/presentation/view_model/board/board_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        BlocProvider(
          create: (context) => getIt<BoardBloc>(),
          child: const RegistrationScreen(),
        ),
        BlocProvider(
          create: (context) => getIt<RegisterBloc>(),
          child: const RegistrationScreen(),
        ),

      ],
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
