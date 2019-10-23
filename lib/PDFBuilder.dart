import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';

String generatedPdfFilePath;

Future setupPDF() async {
  var htmlContent = """
    <h1 style="color: #5e9ca0; text-align: center;"><strong><span style="color: #ff0000;">مصلحة</span> <span style="color: #ffff00;">اﻷحوال</span> <span style="color: #333333;">المدنية</span> - نموذج التسجيل</strong></h1>
<div>
<div style="text-align: center;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <strong>هذا&nbsp;النموذج&nbsp;هو&nbsp;نموذج&nbsp;تجريبي،&nbsp;يتم&nbsp;به&nbsp;المشاركة&nbsp;فى&nbsp;مسابقة&nbsp;تطبيقات&nbsp;مصر&nbsp;للخدمات&nbsp;الحكومية&nbsp;فى</strong></div>
<div style="text-align: center;"><strong>&nbsp;العام&nbsp;2019&nbsp;وجميع&nbsp;حقوق&nbsp;العمل&nbsp;محفوظة&nbsp;لدى&nbsp;المبرمجين&nbsp;اﻷصليين،&nbsp;أى&nbsp;تشابه&nbsp;بين&nbsp;هذا&nbsp;النموذج&nbsp;وبين</strong></div>
<div style="text-align: center;"><strong>&nbsp;النموذج&nbsp;الحكومي&nbsp;هو&nbsp;من&nbsp;باب&nbsp;التجربة والنمذجة&nbsp;وليس&nbsp;إلا،&nbsp;لذلك&nbsp;وجب&nbsp;التنويه.</strong></div>
<div>&nbsp;</div>
</div>
<h4 style="color: #2e6c80; text-align: center;">هذا الملف يحتوى على جميع بيانات التى استخدمتها عند التسجيل، برجاء مراجعتها وعند وجود أى خطأ يرجي التواصل معنا</h4>
<table class="editorDemoTable" style="width: 559px;">
<thead>
<tr>
<td style="width: 324px; text-align: center;">التفاصيل</td>
<td style="width: 116px; text-align: center;">البيان</td>
</tr>
</thead>
<tbody>
<tr style="text-align: center;">
<td style="width: 324px; text-align: center;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">
<div>
<div>البريد&nbsp;اﻹلكترونى</div>
</div>
</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">&nbsp;النوع</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">الديانة</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">تاريخ الميلاد</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">محافظة الميلاد</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">مركز الميلاد</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">اسم اﻷب</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">ديانة اﻷب</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">جنسية اﻷب</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">اسم اﻷم</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">ديانة اﻷم</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">جنسية اﻷم</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">اسم الزوج/ة</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">نوع البطاقة</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">رقم البطاقة</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">المحافظة</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">المدينة</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">المجمع السكنى/ الحي</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">اسم الشارع</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">رقم العقار</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">اعلى مؤهل علمى</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">اسم المؤهل</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">سنة الحصول عليه</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">جامعة / وزارة</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">كلية / معهد / مدرسة</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">الوظيفة</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">سنة شغل الوظيفة</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">جهة العمل</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">
<div>
<div>مكتب&nbsp;السجلّ&nbsp;التجاري</div>
</div>
</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">
<div>
<div>رقم السجلّ التجاري</div>
</div>
</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">
<div>
<div>
<div>
<div>الموقف&nbsp;من&nbsp;العسكرية</div>
</div>
</div>
</div>
</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">
<div>
<div>
<div>
<div>
<div>
<div>رقم&nbsp;الخدمة&nbsp;العسكرية</div>
</div>
</div>
</div>
</div>
</div>
</td>
</tr>
<tr style="text-align: center;">
<td style="width: 324px;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>تاريخ الخدمة&nbsp;العسكرية</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</td>
</tr>
<tr>
<td style="width: 324px; text-align: center;">&nbsp;اعتبره من الداتابِيز ناو</td>
<td style="width: 116px;">
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div style="text-align: center;">الموطن&nbsp;اﻹنتخابى</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</td>
</tr>
</tbody>
</table>
<p><strong>&nbsp;</strong></p>
    """;

  Directory appDocDir = await getExternalStorageDirectory();
  var targetPath = appDocDir.path;
  var targetFileName = "example-pdf";

  var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
      htmlContent, targetPath, targetFileName);
  generatedPdfFilePath = generatedPdfFile.path;
  debugPrint(generatedPdfFilePath);
}