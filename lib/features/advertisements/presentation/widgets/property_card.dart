import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/property_item.dart';
import '../../../detailsAboutProperty/presentation/manager/get property/get_property_cubit.dart';
import '../../../detailsAboutProperty/presentation/manager/get property/get_property_state.dart';
import '../../../detailsAboutProperty/presentation/view/views/property_details.dart';

class PropertyCard extends StatefulWidget {


  const PropertyCard({super.key});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
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
          } else if (state is GetPropertyStateSuccess) {
            if (state.properties != null && state.properties!.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.properties!.length,
                itemBuilder: (context, index) =>
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PropertyDetailScreen(propertyId:state.properties![index].propertyId??24,)),
                        );
                      },
                        child: PropertyItem(property: state.properties![index])),
              );
            } else {

               return const Center(child: Text('لا توجد بيانات لعرضها'));
            }
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
