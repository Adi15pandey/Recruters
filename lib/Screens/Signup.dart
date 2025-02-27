import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rekruters/Screens/Loginscreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isChecked = false;
  bool _isPasswordVisible = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/Images/rekruters-logo.png', height: 60),
              const SizedBox(height: 5),
              Text(
                'Create New Account',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildTextField('First Name', FontAwesomeIcons.user, firstNameController)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField('Last Name', FontAwesomeIcons.user, lastNameController)),
                ],
              ),
              _buildTextField('Enter your Email ID', FontAwesomeIcons.envelope, emailController),
              _buildTextField('Mobile', FontAwesomeIcons.phone, mobileController),
              _buildTextField('Enter your Password', FontAwesomeIcons.lock, passwordController, isPassword: true),
              _buildTextField('Confirm Password', FontAwesomeIcons.lock, confirmPasswordController, isPassword: true),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  Flexible(
                    child: Text(
                      'I have read and agree with terms of Rekruters.',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text('SUBMIT', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CandidateLoginScreen()));
                },
                child: Text(
                  'Have an account? Sign In here',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginToken'); // Remove token

    // Navigate to login screen after logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => CandidateLoginScreen()),
          (route) => false, // Remove all previous routes
    );
  }


  Widget _buildTextField(String hintText, IconData icon, TextEditingController controller, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
        ),
      ),
    );
  }

  Future<void> _signup() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('https://rekruters.com/API/AndroidAPI/SignUp'));
      request.body = json.encode({
        "FirstName": firstNameController.text,
        "LastName": lastNameController.text,
        "Email": emailController.text,
        "MobileNo": mobileController.text,
        "Password": passwordController.text,
        "role":"student"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody);

        if (data['Status'] == 'SUCCESS') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['Message'])),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CandidateLoginScreen()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['Message'] ?? 'Signup failed')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
