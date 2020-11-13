// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../widgets/button.dart';
// import '../widgets/text_form_field_style.dart';
// import '../providers/auth.dart';
// import '../models/httpException.dart';

// class RegisterScreen extends StatefulWidget {
//   static const routeName = '/register';
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey();

//   Map<String, String> _authData = {
//     'username': '',
//     'email': '',
//     'password': '',
//     'first_name': '',
//     'last_name': '',
//   };
//   var _isLoading = false;
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Text(message),
//           title: Text('An Error Occured'),
//           actions: [
//             FlatButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('Okay'))
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState.validate()) {
//       print('not Returning');
//       return;
//     }
//     _formKey.currentState.save();
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       await Provider.of<Auth>(context, listen: false).register(
//           _authData['email'],
//           _authData['password'],
//           _authData['username'],
//           _authData['first_name'],
//           _authData['last_name']);
//     } on HttpException catch (error) {
//       var errormessage = 'Registration failed';
//       if (error.toString().contains('Email already exists,')) {
//         errormessage =
//             "Try different username,Email already exists, please try 'Reset Password,'";
//       } else if (error.toString().contains('[jwt_auth] incorrect_password')) {
//         errormessage =
//             'The password you entered for the email address  is incorrect.';
//       } else if (error.toString().contains('[jwt_auth] invalid_username')) {
//         errormessage = 'This email is not valid';
//       }
//       _showErrorDialog(errormessage);
//     } catch (error) {
//       var errormessage = 'Could not authenticate you. Please try again later';
//       print(error);
//       _showErrorDialog(errormessage);
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: 100,
//                 // margin: EdgeInsets.all(MediaQuery.of(context).size.width / 5),
//                 child: Image.asset('assets/Logo.png'),
//                 color: Colors.blue,
//               ),
//               Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       buildTextFormStyle(
//                         MediaQuery.of(context).size.height / 9,
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'First Name',
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.only(
//                                 left: MediaQuery.of(context).size.height / 13),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           // ignore: missing_return
//                           validator: (value) {
//                             if (value.isEmpty) return 'First Name is Empty';
//                           },
//                           onSaved: (newValue) {
//                             _authData['first_name'] = newValue;
//                           },
//                         ),
//                       ),
//                       buildTextFormStyle(
//                         MediaQuery.of(context).size.height / 9,
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Last Name',
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.only(
//                                 left: MediaQuery.of(context).size.height / 13),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           // ignore: missing_return
//                           validator: (value) {
//                             if (value.isEmpty) return 'Last Name is Empty!';
//                           },
//                           onSaved: (newValue) {
//                             _authData['last_name'] = newValue;
//                           },
//                         ),
//                       ),
//                       buildTextFormStyle(
//                         MediaQuery.of(context).size.height / 9,
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Username',
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.only(
//                                 left: MediaQuery.of(context).size.height / 13),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           // ignore: missing_return
//                           validator: (value) {
//                             if (value.isEmpty) return 'UserName is Empty!';
//                           },
//                           onSaved: (newValue) {
//                             _authData['username'] = newValue;
//                           },
//                         ),
//                       ),
//                       buildTextFormStyle(
//                         MediaQuery.of(context).size.height / 9,
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.only(
//                                 left: MediaQuery.of(context).size.height / 13),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           // ignore: missing_return
//                           validator: (value) {
//                             if (value.isEmpty || !value.contains('@'))
//                               return 'Invalid email!';
//                           },
//                           onSaved: (newValue) {
//                             _authData['email'] = newValue;
//                           },
//                         ),
//                       ),
//                       buildTextFormStyle(
//                         MediaQuery.of(context).size.height / 9,
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.only(
//                                 left: MediaQuery.of(context).size.height / 13),
//                           ),
//                           obscureText: true,
//                           // ignore: missing_return
//                           validator: (value) {
//                             if (value.isEmpty || value.length < 5)
//                               return 'Password is too short!';
//                           },
//                           onSaved: (newValue) {
//                             _authData['password'] = newValue;
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(top: 10, left: 25, right: 20),
//                         child: Text(
//                             'By creating an account you agree to our Terms of Service and Privacy Policy'),
//                       ),
//                       if (_isLoading)
//                         CircularProgressIndicator()
//                       else
//                         AppButton(name: 'Register', onPressed: _submit),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
