import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/contact_item_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.03),

              SectionWidget(
                title: 'عند استخدامك لموقعنا أو تطبيقنا، قد نقوم بجمع بعض المعلومات التالية:',
                content: '''
- المعلومات الشخصية: مثل الاسم، البريد الإلكتروني، رقم الهاتف عند التسجيل أو عند التواصل معنا.
- معلومات الاستخدام: مثل نوع الجهاز، عنوان الـ IP، الصفحات التي تزورها، ومدة تفاعلك مع الموقع.
- ملفات تعريف الارتباط (Cookies): نستخدمها لتحسين تجربتك وتقديم محتوى مناسب لاحتياجاتك.
                ''',
              ),
              SectionWidget(
                title: 'كيف نستخدم بياناتك؟',
                content: '''
✔️ تحسين وتخصيص تجربتك على الموقع.
✔️ التواصل معك للرد على استفساراتك أو تقديم الدعم الفني.
✔️ إرسال إشعارات حول الخدمات أو العروض الجديدة (بموافقتك).
✔️ تحليل أداء الموقع وتطويره لضمان أفضل تجربة للمستخدمين.
                ''',
              ),
              SectionWidget(
                title: 'مشاركة البيانات مع أطراف ثالثة',
                content:
                    'نحن لا نبيع أو نؤجر بياناتك الشخصية لأي جهة خارجية. قد نقوم بمشاركة بعض المعلومات مع مزودي الخدمات الذين يساعدوننا في تشغيل الموقع، ولكن ذلك يكون وفقًا لاتفاقيات تضمن خصوصية بياناتك.',
              ),
              SectionWidget(
                title: 'حماية بياناتك',
                content:
                    'نعمل على تأمين بياناتك من خلال استخدام تقنيات التشفير وإجراءات الأمان الحديثة لمنع أي اختراق أو استخدام غير مصرح به.',
              ),
              SectionWidget(
                title: 'حقوقك',
                content: '''
✅ طلب الاطلاع على بياناتك الشخصية.
✅ تعديل أو تحديث معلوماتك الشخصية.
✅ طلب حذف بياناتك من أنظمتنا.
                ''',
              ),
              SectionWidget(
                title: 'ملفات تعريف الارتباط (Cookies)',
                content:
                    'يستخدم موقعنا ملفات تعريف الارتباط لتحسين تجربتك. يمكنك التحكم في هذه الملفات من خلال إعدادات المتصفح الخاص بك.',
              ),
              SectionWidget(
                title: 'التعديلات على سياسة الخصوصية',
                content:
                    'قد نقوم بتحديث هذه السياسة من وقت لآخر، لذا يُرجى مراجعتها بشكل دوري لمعرفة أي تغييرات.',
              ),
              SectionWidget(
                title: 'التواصل معنا',
                content: 'إذا كان لديك أي استفسارات حول سياسة الخصوصية، يمكنك التواصل معنا عبر:',
              ),

              SizedBox(height: screenHeight * 0.02),

              ContactItemWidget(
                text: 'البريد الإلكتروني: peron@gmail.com',
                iconPath: Images.emailIcon, 
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.015),
              ContactItemWidget(
                text: 'رقم الهاتف: 0116625783',
                iconPath: Images.phoneIcon, 
                screenWidth: screenWidth,
              ),

              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
