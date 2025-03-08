import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/utils/api_service.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/notification/data/repo/get_notification_repo_imp.dart';
import 'package:peron_project/features/notification/presentation/manager/get%20notifications/notification_cubit.dart';
import 'package:peron_project/features/notification/presentation/view/views/notification_body.dart';
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("الإشعارات", style: theme.headlineMedium!.copyWith(fontSize:20 )),
        centerTitle: true,

        leading: CustomArrowBack(),
      ),
      body: BlocProvider(
  create: (context) => NotificationCubit(GetNotificationRepoImp(apiService: ApiService(Dio()))),
  child: NotificationBodyView(),
),
    );
  }
}
