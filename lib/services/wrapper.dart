
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:specialite_foodapp/screens/homeScreen.dart';
import 'package:specialite_foodapp/screens/loginScreen.dart';

import '../classes/allClasses.dart';

class Wrapper extends StatelessWidget {
  static const routeName = '/Wrapper';

  @override
  Widget build(BuildContext context) {

    final firebaseUser =   Provider.of<AppUser>(context);

    if(firebaseUser!=null) {
    return homeScreen();
    }
    else {
      return loginScreen();
    }

  }
}
