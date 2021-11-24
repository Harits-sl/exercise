import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:http/http.dart' as http;

class AuthGoogle {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      // final AuthCredential credential = GoogleAuthProvider.credential(
      //   accessToken: googleSignInAuthentication.accessToken,
      //   idToken: googleSignInAuthentication.idToken,
      // );

      // print('ini googleSignInAccount $googleSignInAccount');
      // print('access token ${googleSignInAuthentication.accessToken}');
      // print('id token ${googleSignInAuthentication.idToken}');
      // print('ini credential $credential');

      // await _auth.signInWithCredential(credential);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  handleSignInWithOauth() async {
    var clientSecret =
        '{"installed":{"client_id":"794128228843-rup6n22qnt4knafa9r1bcbs84skhak12.apps.googleusercontent.com","project_id":"jamkrindo-245911","auth_uri":"https://accounts.google.com/o/oauth2/auth","token_uri":"https://oauth2.googleapis.com/token","auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs","redirect_uris":["urn:ietf:wg:oauth:2.0:oob","http://localhost"]}}';

    GoogleOAuth2Client client = GoogleOAuth2Client(
        redirectUri: 'com.buildwithangga.app:/74ee-125-164-2-161.ngrok.io',
        customUriScheme: 'com.buildwithangga.app');

    //Then, instantiate the helper passing the previously instantiated client
    // OAuth2Helper oauth2Helper = OAuth2Helper(client,
    //     grantType: OAuth2Helper.AUTHORIZATION_CODE,
    //     clientId:
    //         '794128228843-rup6n22qnt4knafa9r1bcbs84skhak12.apps.googleusercontent.com',
    //     clientSecret: clientSecret,
    //     scopes: ['email']);

    //Request a token using the Authorization Code flow...
    AccessTokenResponse tknResp = await client.getTokenWithAuthCodeFlow(
      clientId:
          '794128228843-rup6n22qnt4knafa9r1bcbs84skhak12.apps.googleusercontent.com',
      clientSecret: clientSecret,
      scopes: ['email'],
    );

    print('respon $tknResp');

    return tknResp;
  }
}
