import 'package:flutter/material.dart';
import 'package:peron_project/features/beginning/presentation/view/views/beginning_body_view.dart';

class BeginningView extends StatelessWidget {
  const BeginningView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BeginningBodyView(),
    );
  }
}
