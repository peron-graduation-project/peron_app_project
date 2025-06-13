import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';
import '../../../../../core/helper/colors.dart';
import '../../../../../core/widgets/custom_arrow_back.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "سياسة الخصوصية",
          style: theme.headlineMedium!.copyWith(fontSize: 20),
        ),
        leading: CustomArrowBack(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 1,
            height: 1,
            color: AppColors.dividerColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: ListView(
          children: [
            Text(
              'نحن في [بيرون] نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية. توضح هذه السياسة كيف نقوم بجمع بياناتك واستخدامها وحمايتها عند استخدامك لخدماتنا.',
              style: theme.titleMedium?.copyWith(
                color: Color(0xff282929),
                fontFamily: Fonts.primaryFontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'عند استخدامك لموقعنا أو تطبيقنا، قد نقوم بجمع بعض المعلومات التالية:',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 8.0),
            Text(
              'المعلومات الشخصية: مثل الاسم، البريد الإلكتروني، رقم الهاتف عند التسجيل أو عند التواصل معنا.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 4.0),
            Text(
              'معلومات الاستخدام: مثل نوع الجهاز، عنوان الـ IP، الصفحات التي تزورها، ومدة تفاعلك مع الموقع.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 4.0),
            Text(
              'ملفات تعريف الارتباط (Cookies): نستخدمها لتحسين تجربتك وتقديم محتوى مناسب لاحتياجاتك.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 16.0),
            Text(
              'كيف نستخدم بياناتك؟',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 8.0),
            Text(
              '✔️ تحسين وتخصيص تجربتك على الموقع.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 4.0),
            Text(
              '✔️ التواصل معك للرد على استفساراتك أو تقديم الدعم الفني.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 4.0),
            Text(
              '✔️ إرسال إشعارات حول الخدمات أو العروض الجديدة (بموافقتك).',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 4.0),
            Text(
              '✔️ تحليل أداء الموقع وتطويره لضمان أفضل تجربة للمستخدمين.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 16.0),
            Text(
              'مشاركة البيانات مع أطراف ثالثة',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 8.0),
            Text(
              'نحن لا نبيع أو نؤجر بياناتك الشخصية لأي جهة خارجية. قد نقوم بمشاركة بعض المعلومات مع مزودي الخدمات الذين يساعدوننا في تشغيل الموقع، ولكن ذلك يكون وفقًا لاتفاقيات تضمن خصوصية بياناتك.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 16.0),
            Text(
              'حماية بياناتك',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 8.0),
            Text(
              'نعمل على تأمين بياناتك من خلال استخدام تقنيات التشفير وإجراءات الأمان الحديثة لمنع أي اختراق أو استخدام غير مصرح به.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 16.0),
            Text(
              'حقوقك',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 8.0),
            Text(
              '✅ طلب الاطلاع على بياناتك الشخصية.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 4.0),
            Text(
              '✅ تعديل أو تحديث معلوماتك الشخصية.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 4.0),
            Text(
              '✅ طلب حذف بياناتك من أنظمتنا.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 16.0),
            Text(
              'ملفات تعريف الارتباط (Cookies)',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 8.0),
            Text(
              'يستخدم موقعنا ملفات تعريف الارتباط لتحسين تجربتك. يمكنك التحكم في هذه الملفات من خلال إعدادات المتصفح الخاص بك.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 16.0),
            Text(
              'التعديلات على سياسة الخصوصية',
              style: theme.displaySmall?.copyWith(color: Color(0xff282929),fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text(
              'قد نقوم بتحديث هذه السياسة من وقت لآخر، لذا يُرجى مراجعتها بشكل دوري لمعرفة أي تغييرات.',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            const SizedBox(height: 16.0),
            Text(
              'التواصل معنا',
              style: theme.displaySmall?.copyWith(color: Color(0xff282929),fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text(
              'إذا كان لديك أي استفسارات حول سياسة الخصوصية، يمكنك التواصل معنا عبر:',
              style: theme.displaySmall?.copyWith(color: Color(0xff818181)),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Icon(Icons.email,color: AppColors.primaryColor,size: 20,),
                SizedBox(width: 10,),
                Text('البريد الالكتروني:peron@gmail.com',style: theme.labelLarge?.copyWith(color: AppColors.primaryColor),)
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Icon(Icons.phone,color: AppColors.primaryColor,size: 20,),
                SizedBox(width: 10,),
                Text('رقم الهاتف:061119723643',style: theme.labelLarge?.copyWith(color: AppColors.primaryColor),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
