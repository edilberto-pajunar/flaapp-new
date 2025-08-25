import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/wrapper/view/wrapper_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AppBloc>(),
      child: WrapperView(),
    );
  }
}
