import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // change Language variable
    var lan = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        
        return Scaffold(
          appBar: AppBar(
            title: Text(lan.getTexts('setting').toString()),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Directionality(
            textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 50,
                            right: (lan.isEn ? 0 : 20),
                            left: (lan.isEn ? 20 : 0),
                            bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(lan.getTexts('ar').toString(),
                                style: Theme.of(context).textTheme.bodyText1),
                            Switch(
                              value: lan.isEn,
                              onChanged: (newValue) {
                                lan.changeLan();
                                /* Navigator.of(context).pop(); */
                              },
                            ),
                            Text(lan.getTexts('en').toString(),
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 25,
                        indent: 50,
                        endIndent: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: (lan.isEn ? 0 : 20),
                            left: (lan.isEn ? 20 : 0),
                            bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(lan.getTexts('dark').toString(),
                                style: Theme.of(context).textTheme.bodyText1),
                            Switch(
                              value: cubit.isDark,
                              onChanged: (newValue) {
                                cubit.changeAppMode();
                                /* Navigator.of(context).pop(); */
                              },
                            ),
                            Text(lan.getTexts('bright').toString(),
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
