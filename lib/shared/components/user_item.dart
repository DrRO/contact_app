import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modules/add_contact_screen.dart';
import '../../modules/profile_screen.dart';
import '../cubit/cubit.dart';

class UserItem extends StatefulWidget {
  Map? contacts;

  UserItem({this.contacts});

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    // change theme variable
    var changeTheme = AppCubit.get(context);

    String name = widget.contacts!['name'];
    String job = widget.contacts!['job'];
    String phone = widget.contacts!['phone'];
    String address = widget.contacts!['address'];
    String gender = widget.contacts!['gender'];
    String notes = widget.contacts!['notes'];

    int id = widget.contacts!['id'];

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              //change border color acc to theme
              border: changeTheme.isDark
                  ? Border.all(color: Colors.grey)
                  : Border.all(color: Colors.white10),

              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 2, right: 10),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 5, right: 5),
                child: InkWell(
                  onTap: () {
                    /*  print('print contact info ' +
                                    id.toString() +
                                    ' ' +
                                    name +
                                    ' ' +
                                    job +
                                    ' ' +
                                    phone +
                                    ' ' +
                                    notes); */
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                  name: name,
                                  address: address,
                                  job: job,
                                  notes: notes,
                                  phone: phone,
                                  gender: gender,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),

                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.deepOrange[300],
                        child: AppCubit.changeGender(gender),
                      ),

                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.contacts!['name'],
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              ' $job',
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              phone,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),

                      // Creating a icon button
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                              iconSize: 30,
                              color: Colors.green,
                              icon: const Icon(
                                Icons.phone,
                              ),

                              // the method which is called when button is pressed

                              onPressed: () {
                                launch('tel:${phone}');
                              },
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 20,
                                  color: Colors.grey,
                                  icon: const Icon(
                                    Icons.edit,
                                  ),

                                  // the method which is called
                                  // when button is pressed
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddContactScreen(
                                                id: id,
                                                existance: 'update',
                                                name: name,
                                                address: address,
                                                job: job,
                                                notes: notes,
                                                phone: phone,
                                                gender: gender,
                                              )),
                                    );
                                  },
                                ),
                                IconButton(
                                  iconSize: 20,
                                  color: Colors.grey,
                                  icon: const Icon(Icons.delete),

                                  // the method which is called
                                  // when button is pressed
                                  onPressed: () {
                                    AppCubit.get(context).deleteFromDatabase(
                                        widget.contacts!['id']);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
