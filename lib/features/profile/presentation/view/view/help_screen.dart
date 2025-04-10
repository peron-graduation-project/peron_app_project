import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/build_text_form_field.dart';
import 'package:peron_project/core/widgets/custom_button.dart';

import '../../../../../core/widgets/custom_arrow_back.dart';
import '../../../../authentication/presentation/view/widgets/phone_field.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _formHelpKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
        var theme=Theme.of(context).textTheme;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'تحتاج إلى مساعدة؟',
              style: theme.headlineMedium!.copyWith(fontSize: 20),
            ),
            centerTitle: true,
            leading: CustomArrowBack(),
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(
                thickness: 1,
                height: 1,
                color: AppColors.dividerColor,
              ),
            ),
          ),
          body: Form(
            key: _formHelpKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.07,
                vertical: screenHeight * 0.02,
              ),
              child: ListView(
                children: [
                  Text(
                    'مرحبًا بك!',
                    textAlign: TextAlign.center,
                    style:theme.headlineMedium?.copyWith(color: AppColors.primaryColor,fontSize: 20)
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '" هل تحتاج إلى مساعدة؟ فريقنا جاهز للتواصل معك في أقرب وقت ! "',
                    style: theme.titleMedium?.copyWith(color: Color(0xff818181))
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  buildTextField("الإسم", TextInputType.name, controller: _fullNameController),
                  const SizedBox(height: 15.0),
                  buildTextField("البريد الإلكتروني", TextInputType.emailAddress, controller: _emailController),
                  const SizedBox(height: 15.0),
                  PhoneFieldInput(controller: _phoneController),
                  buildTextField("الوصف / الاستفسار", TextInputType.text, controller: _descriptionController,maxLines: 3),
                  SizedBox(height: 15),
               CustomButton(
                   textColor: Colors.white, text: 'إرسال', backgroundColor: AppColors.primaryColor,
                 onPressed: (){
                   if (_formHelpKey.currentState!.validate() ) {
                     ScaffoldMessenger.of(context).showSnackBar(

                       const SnackBar(
                         backgroundColor: Colors.green,
                           content: Text('تم الإرسال')),
                     );
                   return ;
                   } else {
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                         backgroundColor: Colors.red,
                           content: Text('يرجى إدخال البيانات بشكل صحيح')),
                     );
                   }
                 },
               )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
