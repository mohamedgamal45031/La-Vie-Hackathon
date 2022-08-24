import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {

  static final _clientIDWeb = '184594152879-p6bkhc8qcus9di94ielqfs50ugtrn241.apps.googleusercontent.com';
  static final googleSignIn = GoogleSignIn(clientId: _clientIDWeb);
  static Future<GoogleSignInAccount?> login()=> googleSignIn.signIn();
  static Future logout()=> googleSignIn.disconnect();

}
