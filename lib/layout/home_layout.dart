import 'package:contactapp/modules/add_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    var lan = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                lan.getTexts('contact_app').toString(),
                
                
              ),
              centerTitle: true,
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Delete All', 'About', 'Settings'}
                        .map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: choice == 'Delete All'
                            ? Text(lan.getTexts('delete_all').toString())
                            : choice == 'About'
                                ? Text(lan.getTexts('about_app').toString())
                                : Text(lan.getTexts('setting').toString()),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
              child: cubit.screens[cubit.screenIndex],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddContactScreen(
                            id: 0,
                            existance: 'new',
                          )),
                );
              },
            ),
          );
        });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Delete All':
        AppCubit.get(context).deleteAll();
        break;
      case 'About':
        Navigator.pushNamed(context, '/about');
        break;
      case 'Settings':
        //print('Settings');
        Navigator.pushNamed(context, '/settings');

        break;
    }
  }
}
