import 'package:contactapp/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sqflite/sqflite.dart';

import '../../modules/setting_screen.dart';
import '../../modules/users_screen.dart';
import '../local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Map> newcontacts = [];

  int screenIndex = 0;
  List<Widget> screens = [
    const UsersScreen(),
    SettingScreen(),
  ];
  Database? database;

  void updateDatabase(
      {required String name,
      required String phone,
      required String job,
      required String address,
      required String notes,
      required String gender,
      required int id}) async {
    database!.rawUpdate(
        'UPDATE contacts SET name = ?, phone = ?, job = ?, address = ?, notes = ?, gender = ?    WHERE id = ?',
        [
          '$name',
          '$phone',
          '$job',
          '$address',
          '$notes',
          '$gender',
          id
        ]).then((value) {
      getDataBase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteFromDatabase(int id) async {
    database!.rawDelete('DELETE FROM contacts WHERE id = ?', [id]).then((value) {
      getDataBase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void deleteAll() async {
    database!.rawDelete('DELETE FROM contacts').then((value) {
      getDataBase(database);
      emit(AppDeleteAllState());
    });
  }

  void createDatabase() {
    openDatabase(
      'contact.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(

                /* 'CREATE TABLE contacts (id INTEGER PRIMARY KEY, name TEXT, job TEXT, phone TEXT, status TEXT)') */
                'CREATE TABLE contacts (id INTEGER PRIMARY KEY, name TEXT, job TEXT, phone TEXT, address TEXT, notes TEXT, gender TEXT )')
            .then((value) => print('Table Created'))
            .catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataBase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void getDataBase(database) async {
    newcontacts = [];

    database!.rawQuery('SELECT * FROM contacts').then((value) {
      //print(value);
      value.forEach((element) {
        print(element['id']);
        newcontacts.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  inserToDatabase({
    required String name,
    required String phone,
    required String job,
    required String address,
    required String notes,
    required String gender,
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO contacts (name, job, phone, address, notes, gender) VALUES ("$name","$job","$phone", "$address", "$notes", "$gender")')
          .then((value) {
        getDataBase(database);
        print('$value Inserted Successfully');
        emit(AppInsertDatabaseState());
      }).catchError((error) {
        print('Error When inserting Table ${error.toString()}');
      });
    });
  }

  //Change Language
  bool isEn = true;

  Map<String, Object> textsAr = {
    "choose_lan": "اللغة",
    "ar": "عربى",
    "en": "إنجليزى",
    "contact_app": "جهات الإتصال",
    "setting": "الإعدادات",
    "contacts": "جهات الإتصال",
    "cancel": "إلغاء",
    "delete": "مسح",
    "delete_all": "حذف الكل",
    "about_app": "عن المبرمج",
    "name": "الإسم ",
    "phone": "رقم الموبايل",
    "title": "الوظيفة",
    "enter_contact_name": "أضف الإسم و اللقب",
    "phone_must_not_be_empty": "أضف رقم التليفون",
    "title_must_not_be_empty": "أضف الوظيفة",
    "address": "العنوان",
    "enter_contact_address": "أضف العنوان",
    "notes": "ملاحظات",
    "enter_contact_notes": "أضف ملاحظات",
    "choose_theme": "السمة",
    "bright": "ساطع",
    "dark": "داكن",
    "there_is_no_contacts": "لا يوجد جهات إتصال لديك حاليا",
    "start_add_your_contacts": "إبدأ بإضافة جهات الإتصال",
    "info":
        " -أنا مطورة لتطبيقات الموبايل ، لدي أكثر من 5 سنوات من الخبرة في تطوير تطبيقات الأجهزة المحمولة باستخدام Java \n -لدي العديد من التطبيقات المنشورة على google play \n -حصلت على عدة شهادات Nanodegree من Udacity فى مجالات Full stack , Android بدعم من مبادرة مليون مبرمج عربى ووزارة الإتصالات المصرية \n - عضوة فى Woman Techmakers التابعة لجوجل",
    "education": "التعليم",
    "education_info": "",
    "about": "عن مبرمج التطبيق",
    "follow": "تابعنى",
    "add_contact": 'أضف جهة إتصال',
    "edit_contact": "تعديل جهة الإتصال",
    "save": "حفظ",
    "update_data": "تعديل",
    "profile": "معلومات جهة الإتصال",
  };
  Map<String, Object> textsEn = {
    "choose_lan": "Language",
    "ar": "Arabic",
    "en": "ُEnglish",
    "contact_app": "Contact App",
    "setting": "Setting",
    "contacts": "My Contacts",
    "follow": "Follow me",
    "cancel": "Cancel",
    "delete": "Delete",
    "delete_all": "Delete All",
    "about_app": "ِAbout me",
    "name": "Name",
    "phone": "Phone",
    "title": "Title",
    "enter_contact_name": "Enter Contact First and Last Name",
    "phone_must_not_be_empty": "Enter phone number",
    "title_must_not_be_empty": " Enter Title",
    "address": "Address",
    "enter_contact_address": "Enter contact address",
    "notes": "Notes",
    "enter_contact_notes": "Enter contact notes",
    "choose_theme": "Theme",
    "bright": "Bright",
    "dark": "Dark",
    "there_is_no_contacts": "There is no any contacts",
    "start_add_your_contacts": "Start add contacts",
    "education": "Education",
    "about": "About me",
    "add_contact": 'Add User',
    "edit_contact": "Edit User info ",
    "save": "Save",
    "update_data": "Update",
    "profile": "Contact Profile",
    "info":
        "- I am Mobile app developer , I have more than 5 years experience in mobile app development using Java. \n - I have many app published on google play. \n - I get several Nanodegree certificates from Udacity in the fields of Full stack, Android, with the support of the One Million Arab Coders Initiative and the Egyptian Ministry of Communications. \n - I am a member of Google Woman Techmakers.",
  };

  ///Change Language to Arabic
  void changeLan({bool? fromShared}) {
    if (fromShared != null) {
      isEn = fromShared;
      emit(AppChangeLanguageState());
    } else
      isEn = !isEn;
    CacheHelper.putBoolean(key: 'isEn', value: isEn).then((value) {
      emit(ChangeModeState());
    });
  }

  Object getTexts(String txt) {
    if (isEn == true) return textsEn[txt]!;
    return textsAr[txt]!;
  }


  ///////////////////////////////////////////////////
  ///Change Theme Mode to Dark
  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeModeState());
    } else
      isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(ChangeModeState());
    });
  }

  // change image according to Gender
  static changeGender(String gender) {
    switch (gender) {
      case 'male':
        return SvgPicture.asset(
          'assets/images/man.svg',
          height: 50,
          width: 50,
        );
      case 'female':
        return SvgPicture.asset(
          'assets/images/woman.svg',
          height: 50,
          width: 50,
        );
      case 'anonymous':
        return SvgPicture.asset(
          'assets/images/user.svg',
          height: 50,
          width: 50,
        );

      default:
        return SvgPicture.asset(
          'assets/images/user.svg',
          height: 50,
          width: 50,
        );
        
    }
   
  }
}
