import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignette__mobile/app/di/di.dart';
import 'package:vignette__mobile/features/board/presentation/view_model/board/board_bloc.dart';
import 'package:vignette__mobile/features/home/presentation/view/bottom_view/dashboard_view.dart';

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
          child: const Dashboard(),
        ),
        // BlocProvider(
        //   create: (context) => getIt<BoardBloc>(),
        //   child: const RegistrationScreen(),
        // ),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
