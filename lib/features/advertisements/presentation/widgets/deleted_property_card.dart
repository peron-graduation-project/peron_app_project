import 'dart:ui';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/app_snack_bar.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/property_item.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/manager/get property/get_property_cubit.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/manager/get property/get_property_state.dart';

import '../manager/propert_create/property_create_cubit.dart';

class DeletedPropertyCard extends StatefulWidget {
  const DeletedPropertyCard({super.key});

  @override
  State<DeletedPropertyCard> createState() => _DeletedPropertyCardState();
}

class _DeletedPropertyCardState extends State<DeletedPropertyCard> {
  Set<int> restoredIndexes = {};

  void _handleRestore(int index) {
    setState(() {
      restoredIndexes.add(index);
    });

    AppSnackBar.showFromTop(
      context: context,
      title: 'تمت العملية بنجاح',
      message: 'تم استعادة المنشور',
      contentType: ContentType.success,
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<GetPropertyCubit>().getProperties(
      index: 2,
      id: context.read<PropertyCreateCubit>().getId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<GetPropertyCubit, GetPropertyState>(
        builder: (context, state) {
          if (state is GetPropertyStateLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is GetPropertyStateFailure) {
            return Center(child: Text('حدث خطأ: ${state.errorMessage}'));
          } else if (state is GetPropertyStateSuccess &&
              state.properties != null &&
              state.properties!.isNotEmpty) {
            final properties = state.properties!;

            return ListView.builder(
              shrinkWrap: true,
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final property = properties[index];
                final isBlurred = !restoredIndexes.contains(index);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Stack(
                    children: [
                      PropertyItem(property: property),
                      if (isBlurred)
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: Container(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      if (isBlurred)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert, color: Colors.white),
                            onSelected: (value) {
                              if (value == 'استعادة') {
                                _handleRestore(index);
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem<String>(
                                value: 'استعادة',
                                child: Text('استعادة'),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('لا توجد منشورات محذوفة'));
          }
        },
      ),
    );
  }
}
