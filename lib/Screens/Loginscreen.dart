import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rekruters/Screens/Forget.dart';
import 'package:rekruters/Screens/Homescreen.dart';
import 'package:rekruters/Screens/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CandidateLoginScreen extends StatelessWidget {
  const CandidateLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: Center(
                  child: Image.asset(
                    'assets/Images/rekruters-logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'CANDIDATE LOGIN',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                  'Enter your Email ID', Icons.email, emailController),
              const SizedBox(height: 16),
              _buildPasswordField(passwordController),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () async {
                  await _login(
                      context, emailController.text, passwordController.text);
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Forget()));

                },
                icon: const Icon(Icons.lock_outline, color: Colors.blue),
                label: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Signup()));
                },
                child: Text(
                  "Don't have an account? Sign-up",
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 18),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    bool _isPasswordVisible = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return TextField(
          controller: controller,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock, color: Colors.blue),
            hintText: 'Enter your Password',
            hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 18),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _login(BuildContext context, String email,
      String password) async {
    try {
      final url = Uri.parse('https://rekruters.com/API/AndroidAPI/Login');

      var headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3N2VhNTZiNzU1NGRhNWQ2YWExYWU3MSIsImlhdCI6MTczNzE4NTgxNywiZXhwIjoxNzM3MjcyMjE3fQ.0oMKfIVwvOZ-YOelM4WV1WoQqIGBL_62m6De76CIVy4'
      };

      var body = json.encode({
        "UserID": email,
        "Password": password,
        "Token": "6473yrhedn3dt46545bcrgyf37t5rgfe"
      });

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data == null || data.isEmpty) {
          _showMessage(context, "Error: Empty response from server.");
          return;
        }

        if (data["Status"] == "SUCCESS") {
          String loginToken = data["LoginToken"];
          String userName = email.split('@').first;
          await _saveUserName(userName);
          await _saveToken(loginToken);
          await _checkSavedToken();
           // Save the UserID
// Add this line to confirm the token is saved


          print('✅ Login successful');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          _showMessage(context, '❌ Login failed: ${data["Message"]}');
        }
      } else {
        _showMessage(context, '❌ Login failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      _showMessage(context, '❗ An error occurred: $e');
    }
  }
  Future<void> _saveUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }


  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginToken', token);
  }
  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)));
  }

  Future<void> _checkSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('loginToken');

    if (token != null && token.isNotEmpty) {
      print('✅ Saved Token: $token');
    } else {
      print('❌ No token found');
    }
  }
}