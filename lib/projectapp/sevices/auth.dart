import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/models/staff.dart';

class Auth {
  static Staff? currentUser;

  static bool isLogin() {
    return currentUser != null;
  }

  static bool isAdmin() {
    return isLogin() && currentUser?.is_admin == 1;
  }

  static bool isStaff() {
    return isLogin() && currentUser?.is_admin == 0;
  }

}
class AuthPatient{
  static Patient? currentUser;

  static bool isLogin() {
    return currentUser != null;

  }
  static bool isPatient() {
    return isLogin() ;
  }
}

