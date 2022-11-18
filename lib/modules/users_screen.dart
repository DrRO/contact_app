import 'package:contactapp/modules/add_contact_screen.dart';
import 'package:contactapp/modules/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../shared/components/user_item.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
// change Language variable
    var lan = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var contacts = AppCubit.get(context).newcontacts;
        return Directionality(
          textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: ConstrainedBox(
                constraints: const BoxConstraints(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: contacts.isNotEmpty
                          ? Text(
                              lan.getTexts('contacts').toString(),
                              style: const TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 13,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    contacts.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return UserItem(
                                contacts: contacts[index],
                              );
                            },
                            itemCount: contacts.length)
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Center(
                                          child: SvgPicture.asset(
                                    'assets/images/add_user.svg',
                                    height: 100,
                                    width: 100,
                                  ))),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: Column(
                                        children: [
                                          Text(
                                            lan
                                                .getTexts(
                                                    'there_is_no_contacts')
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            lan
                                                .getTexts(
                                                    'start_add_your_contacts')
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
      },
    );
  }
}
