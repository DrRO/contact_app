import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../layout/home_layout.dart';
import '../shared/components/default_form_field.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

//  Form to add new User or edit and Update User info

var nameController;
var phoneController;
var jobController;
var addressController;
var noteController;
var genderValue = 'anonymous';
var formKey = GlobalKey<FormState>();

class AddContactScreen extends StatefulWidget {
  int id;
  String existance;
  String? name;
  String? phone;
  String? job;
  String? address;
  String? notes;
  String? gender;

  AddContactScreen({
    Key? key,
    required this.id,
    required this.existance,
    this.name,
    this.phone,
    this.job,
    this.address,
    this.notes,
    this.gender,
  }) : super(key: key);

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  @override
  Widget build(BuildContext context) {
    var lan = AppCubit.get(context);

    print(widget.gender);
    if (widget.existance == 'new') {
      genderValue == 'anonymous';
    } else {
      setState(() => genderValue = widget.gender.toString());
    }

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

//disable phone back press
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: widget.existance == 'update'
                    ? Text(lan.getTexts('edit_contact').toString())
                    : Text(lan.getTexts('add_contact').toString()),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 0, left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => setState(() => genderValue = 'male'),
                                child: Container(
                                  color: genderValue == 'male'
                                      ? Colors.grey
                                      : Colors.transparent,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.deepOrange[300],
                                    child: SvgPicture.asset(
                                      'assets/images/man.svg',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () => setState(() => genderValue = 'female'),
                                child: Container(
                                  color: genderValue == 'female'
                                      ? Colors.grey
                                      : Colors.transparent,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.deepOrange[300],
                                    child: SvgPicture.asset(
                                      'assets/images/woman.svg',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () =>
                                    setState(() => genderValue = 'anonymous'),
                                child: Container(
                                  color: genderValue == 'anonymous'
                                      ? Colors.grey
                                      : Colors.transparent,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.deepOrange[300],
                                    child: SvgPicture.asset(
                                      'assets/images/user.svg',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 10,
                            right: 20,
                          ),
                          child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              child: Column(
                                //mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DefaultFormField(
                                    controller: widget.existance == 'update'
                                        ? nameController = TextEditingController(
                                            text: widget.name)
                                        : nameController =
                                            TextEditingController(),
                                    label: lan.getTexts('name').toString(),
                                    type: TextInputType.text,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return lan
                                            .getTexts('enter_contact_name')
                                            .toString();
                                      }
                                      return null;
                                    },
                                    prefix: Icons.person,
                                    hintText:
                                        Text(lan.getTexts('contacts').toString()),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DefaultFormField(
                                    controller: widget.existance == 'update'
                                        ? phoneController = TextEditingController(
                                            text: widget.phone)
                                        : phoneController =
                                            TextEditingController(),
                                    label: lan.getTexts('phone').toString(),
                                    type: TextInputType.phone,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return lan
                                            .getTexts('phone_must_not_be_empty')
                                            .toString();
                                      }
                                      return null;
                                    },
                                    prefix: Icons.phone,
                                    hintText: Text(
                                      lan.getTexts('phone').toString(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DefaultFormField(
                                    controller: widget.existance == 'update'
                                        ? jobController = TextEditingController(
                                            text: widget.job)
                                        : jobController = TextEditingController(),
                                    label: lan.getTexts('title').toString(),
                                    type: TextInputType.text,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return lan
                                            .getTexts('title_must_not_be_empty')
                                            .toString();
                                      }

                                      return null;
                                    },
                                    prefix: Icons.title,
                                    hintText: Text(
                                      lan.getTexts('title').toString(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DefaultFormField(
                                    controller: widget.existance == 'update'
                                        ? addressController =
                                            TextEditingController(
                                                text: widget.address)
                                        : addressController =
                                            TextEditingController(),
                                    label: lan.getTexts('address').toString(),
                                    type: TextInputType.text,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return lan
                                            .getTexts('enter_contact_address')
                                            .toString();
                                      }

                                      return null;
                                    },
                                    prefix: Icons.location_pin,
                                    hintText: Text(
                                      lan.getTexts('address').toString(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DefaultFormField(
                                    controller: widget.existance == 'update'
                                        ? noteController = TextEditingController(
                                            text: widget.notes)
                                        : noteController =
                                            TextEditingController(),
                                    label: lan.getTexts('notes').toString(),
                                    type: TextInputType.text,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return lan
                                            .getTexts('enter_contact_notes')
                                            .toString();
                                      }

                                      return null;
                                    },
                                    prefix: Icons.note,
                                    hintText: Text(
                                      lan.getTexts('notes').toString(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          if (widget.existance == 'new') {
                                            cubit
                                                .inserToDatabase(
                                                    name: nameController.text,
                                                    phone: phoneController.text,
                                                    job: jobController.text,
                                                    address:
                                                        addressController.text,
                                                    notes: noteController.text,
                                                    gender: genderValue)
                                                .then((value) {
                                              Navigator.pop(context);
                                              nameController.clear();
                                              phoneController.clear();
                                              jobController.clear();
                                              addressController.clear();
                                              noteController.clear();
                                            },
                                                    Navigator.popAndPushNamed(
                                                        context, '/home'));
                                          } else {
                                            cubit.updateDatabase(
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                job: jobController.text,
                                                id: widget.id,
                                                address: addressController.text,
                                                notes: noteController.text,
                                                gender: genderValue);

                                            Navigator.popAndPushNamed(
                                                context, '/home');
                                          }
                                        }
                                      },
                                      label: widget.existance == 'update'
                                          ? Text(lan
                                              .getTexts('update_data')
                                              .toString())
                                          : Text(lan.getTexts('save').toString()),
                                      icon: const Icon(Icons.save),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
