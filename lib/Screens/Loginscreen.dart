import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rekruters/Screens/Dashboard.dart';
import 'package:rekruters/Screens/Homescreen.dart';
import 'package:rekruters/Screens/Signup.dart';

class CandidateLoginScreen extends StatelessWidget {
  const CandidateLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
              _buildTextField('Enter your Email ID', Icons.email),
              const SizedBox(height: 16),
              _buildPasswordField(),
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
                onPressed: () {},
                icon: const Icon(Icons.lock_outline, color: Colors.blue),
                label: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup()));
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

  Widget _buildTextField(String hintText, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
    );
  }

  Widget _buildPasswordField() {
    bool _isPasswordVisible = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return TextField(
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock, color: Colors.blue),
            hintText: 'Enter your Password',
            hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
}
