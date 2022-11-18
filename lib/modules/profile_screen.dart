import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class ProfileScreen extends StatelessWidget {
  String name;
  String phone;
  String job;
  String address;
  String notes;
  String gender;

  ProfileScreen({
    Key? key,
    required this.name,
    required this.phone,
    required this.job,
    required this.address,
    required this.notes,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lan = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(lan.getTexts('profile').toString()),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Directionality(
              textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.deepOrange[300],
                        child: AppCubit.changeGender(gender),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        phone,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          child: Column(
                            //mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 500, // constrain height
                                child: ListView(children: [
                                  ListTile(
                                    leading: const Icon(Icons.title),
                                    title:
                                        Text(lan.getTexts('title').toString()),
                                    subtitle: Text(job),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: const Icon(Icons.location_pin),
                                    title: Text(
                                        lan.getTexts('address').toString()),
                                    subtitle: Text(address),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: const Icon(Icons.note),
                                    title:
                                        Text(lan.getTexts('notes').toString()),
                                    subtitle: Text(notes),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
