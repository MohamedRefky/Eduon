# Eduon AI Screen - Architecture Documentation

## البنية المعمارية الجديدة

تم تقسيم الشاشة إلى مكونات منفصلة مع فصل كامل بين UI و Logic.

### 📁 هيكل المجلدات

```
lib/screens/eduon_aI/
├── services/
│   └── ai_service.dart          # خدمة API (الـ Logic)
├── models/
│   └── message_model.dart       # نموذج البيانات
├── cubit/
│   ├── ai_cubit.dart            # إدارة الحالة والـ Logic
│   └── ai_state.dart            # حالات التطبيق
├── widgets/
│   ├── message_bubble.dart      # عنصر الرسالة الواحدة
│   ├── chat_input_field.dart    # حقل الإدخال
│   └── messages_list.dart       # قائمة الرسائل
├── cubit/
│   ├── courses_bloc.dart
│   └── ...
├── data/
│   └── ...
└── screen/
    └── edone_ai_screeen.dart    # الشاشة الرئيسية
```

## المكونات

### 1. **AiService** (`services/ai_service.dart`)
- مسؤول عن API calls
- فصل كامل عن الـ UI
- سهل الاختبار والصيانة

### 2. **AiCubit** (`cubit/ai_cubit.dart`)
- إدارة الحالة (State Management)
- التعامل مع الرسائل
- استدعاء الـ Service

### 3. **Widgets المنفصلة**
- **MessageBubble**: عنصر الرسالة الواحدة (UI نقية)
- **ChatInputField**: حقل الإدخال مع تحكم بالتحميل
- **MessagesList**: قائمة الرسائل مع Scroll تلقائي

### 4. **EdoneAiScreen** (`screen/edone_ai_screeen.dart`)
- الشاشة الرئيسية النظيفة والبسيطة
- تجميع جميع المكونات

## المميزات الجديدة

✅ **فصل كامل بين UI و Logic**
✅ **إعادة استخدام المكونات** (Reusable Widgets)
✅ **إدارة حالة قوية** باستخدام BLoC
✅ **سهولة الاختبار**
✅ **صيانة أسهل**
✅ **نفس التصميم والـ UI** (بدون تغييرات)

## كيفية الاستخدام

يتم استدعاء الشاشة بنفس الطريقة القديمة:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const EdoneAiScreen()),
);
```

لا توجد تغييرات على الـ UI أو التصميم!
