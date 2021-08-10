import 'package:books_app/Constants/colors.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/common/themes.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/providers/theme.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _currentSlidervalue = 10.0;
  double sliderValue = 10.0;
  bool _darkTheme = false;
  bool _switchValue = true;
  final AuthService _authService = AuthService();
  final String text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam in odio condimentum, pellentesque ex at, condimentum nisi. Aliquam erat volutpat, proin nisl tellus.';
  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = themeNotifier.getTheme() == darkTheme;
    final dynamic uID = _authService.getUID;
    print(uID);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: uID as String).userData,
        builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
          if (snapshot.hasData) {
            print('Setting Page');
            print(snapshot.data.photoURL);
            final UserData userData = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    automaticallyImplyLeading: false,
                    elevation: 0.0,
                    toolbarHeight: 150,
                    bottom: PreferredSize(
                        child: Container(
                          color: silverDivisor,
                          height: 1.0,
                        ),
                        preferredSize: const Size.fromHeight(1.0)),
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text('Settings',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400, fontSize: 30)),
                          ),
                          _profile(uID, userData),
                        ])),
                body: ListView(
                  padding: const EdgeInsets.only(right: 5, left: 5, bottom: 5),
                  children: ListTile.divideTiles(context: context, tiles: [
                    ListTile(
                      title: Text(
                        'Account Settings',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15, right: 0),
                      title: Text(
                        'Edit Profile',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      trailing: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_forward_ios, size: 14),
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.EDIT_PROFILE),

                        // icon: Icons.arrow_forward_ios,
                        // size: 14,
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15, right: 0),
                      // leading: Slider(
                      //   label: _currentSlidervalue.round().toString(),
                      //   value:
                      //       // widget.locationRange as double ?? _currentSlidervalue,
                      //       _currentSlidervalue,
                      //   min: 0,
                      //   max: 50,
                      //   onChanged: (double value) {
                      //     setState(() {
                      //       // widget.locationRange = value;
                      //       _currentSlidervalue = value;
                      //     });
                      //     sliderValue = value;
                      //   },
                      // ),
                      title: Text(
                        'Set Location Range',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(_currentSlidervalue.toStringAsFixed(2),
                            style: GoogleFonts.poppins()),
                      ),
                      // trailing: IconButton(
                      //   padding: EdgeInsets.zero,
                      //   icon: const Icon(Icons.arrow_forward_ios, size: 14),
                      //   onPressed: () =>
                      //       Navigator.pushNamed(context, Routes.EDIT_PROFILE),

                      //   // icon: Icons.arrow_forward_ios,
                      //   // size: 14,
                      // ),
                    ),
                    Slider(
                      label: _currentSlidervalue.round().toString(),
                      value:
                          // widget.locationRange as double ?? _currentSlidervalue,
                          _currentSlidervalue,
                      min: 0,
                      max: 50,
                      onChanged: (double value) {
                        setState(() {
                          // widget.locationRange = value;
                          _currentSlidervalue = value;
                        });
                        sliderValue = value;
                      },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15, right: 0),
                      title: Text(
                        'Push notifications',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      trailing: Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          activeColor: Colors.black,
                          value: _switchValue,
                          onChanged: (bool val) {
                            setState(() {
                              _switchValue = val;
                            });
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15, right: 0),
                      title: Text(
                        'Dark Mode',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      trailing: Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          activeColor: Colors.black,
                          value: _darkTheme,
                          onChanged: (bool val) {
                            setState(() {
                              _darkTheme = val;
                            });
                            onThemeChanged(val, themeNotifier);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: PreferredSize(
                          child: Container(
                            color: silverDivisor,
                            height: 1.0,
                          ),
                          preferredSize: const Size.fromHeight(1.0)),
                    ),

                    ListTile(
                      title: Text(
                        'More',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ),
                    ExpansionTile(
                      textColor: Theme.of(context).colorScheme.primary,
                      iconColor: Theme.of(context).colorScheme.primary,
                      childrenPadding:
                          const EdgeInsets.only(right: 15, left: 15),
                      title: Text(
                        'About us',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      children: <Widget>[Text(text)],

                      // icon: Icons.arrow_forward_ios,
                      // size: 14,
                    ),
                    ExpansionTile(
                      textColor: Theme.of(context).colorScheme.primary,
                      iconColor: Theme.of(context).colorScheme.primary,
                      childrenPadding:
                          const EdgeInsets.only(right: 15, left: 15),
                      title: Text(
                        'Privacy Policy',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      children: <Widget>[Text(text)],
                      // icon: Icons.arrow_forward_ios,
                      // size: 14,
                    ),
                    ExpansionTile(
                      textColor: Theme.of(context).colorScheme.primary,
                      iconColor: Theme.of(context).colorScheme.primary,
                      childrenPadding:
                          const EdgeInsets.only(right: 15, left: 15),
                      title: Text(
                        'Terms and Conditions',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      children: <Widget>[Text(text)],
                    ),
                    // _accountSettingsDetails(themeNotifier),
                    // _moreWidget()
                  ]).toList(),
                ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<void> onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    value
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  Widget _profile(dynamic uID, UserData userData) {
    return Container(
        padding: const EdgeInsets.only(top: 12, left: 0, right: 0, bottom: 10),
        child: Row(children: <Widget>[
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(userData.photoURL),
          ),
          Container(
            padding: const EdgeInsets.only(left: 9.0, top: 4.0),
            child: Text(
              userData.displayName,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, fontSize: 19),
            ),
          ),
          const Spacer(),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.EDIT_PROFILE);
              },
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ))
        ]));
  }
}
