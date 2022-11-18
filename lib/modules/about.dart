import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class AboutScreen extends StatelessWidget {
  Uri linkedinUrl = Uri.parse('https://www.linkedin.com/in/dr-rasha-omran');
  Uri githubUrl = Uri.parse('https://github.com/DrRO');
  Uri googleUrl = Uri.parse(
      'https://play.google.com/store/apps/developer?id=DrRashaMohamed');

  @override
  Widget build(BuildContext context) {
    var lan = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(lan.getTexts('about').toString()),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Directionality(
              textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.deepOrange[300],
                          child: SvgPicture.asset(
                            'assets/images/rasha.svg',
                            height: 70,
                            width: 70,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Rasha Omran',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Mobile Developer',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            child: Column(
                              //mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 250, // constrain height
                                  child: ListView(children: [
                                    ListTile(
                                      title: Text(
                                          lan.getTexts('about').toString()),
                                      subtitle:
                                          Text(lan.getTexts('info').toString()),
                                    ),
                                  ]),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      lan.getTexts('follow').toString(),
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            iconSize: 50,
                                            color: Colors.green,
                                            icon: SvgPicture.asset(
                                              'assets/images/linkedin.svg',
                                            ),
                                            onPressed: () {
                                              launch('${linkedinUrl}');
                                            },
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          IconButton(
                                            iconSize: 50,
                                            color: Colors.green,
                                            icon: SvgPicture.asset(
                                              'assets/images/github.svg',
                                            ),
                                            onPressed: () {
                                              launch('${githubUrl}');
                                            },
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          IconButton(
                                            iconSize: 50,
                                            color: Colors.green,
                                            icon: SvgPicture.asset(
                                              'assets/images/google_play.svg',
                                            ),
                                            onPressed: () {
                                              launch('${googleUrl}');
                                            },
                                          ),
                                        ]),
                                  ],
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
            ),
          );
        });
  }

  /* Future<void> _launch(BuildContext context, Uri url) async {
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('could_not_launch_this_app')));
  } */
}
