import 'package:flutter/material.dart';
import 'package:rekruters/Screens/Loginscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Curved AppBar with Logo and Login Button
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(189, 217, 255, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo on the left side
                      Image.asset(
                        'assets/Images/rekruters-logo.png',
                        height: 30,
                        fit: BoxFit.contain,
                      ),
                      // Login button on the right side
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CandidateLoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700, // A richer blue color
                          foregroundColor: Colors.white, // White text for contrast
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Better padding
                          elevation: 5, // Adds slight shadow for depth
                        ),
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  // Greeting Text
                  Text(
                    'Hey, Aditya',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Welcome to Rekruters',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Search Bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for jobs...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Curved Banner Image
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/Images/Questival - college banner (1).png',
                  fit: BoxFit.cover,
                  height: 130,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Text and Image Grid Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'We are Provide',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.1,
              children: [
                _buildCategoryCard(context, 'Practice', 'assets/Images/practice.png', Color(0xFFFFE4B5)), // Light Orange
                _buildCategoryCard(context, 'Jobs', 'assets/Images/job.png', Color(0xFFDFFFD6)), // Light Green
                _buildCategoryCard(context, 'Internship', 'assets/Images/intern.png', Color(0xFFF5D0C5)), // Light Pink
                _buildCategoryCard(context, 'Compete', 'assets/Images/enterpre.png', Color(0xFFD6E4FF)), // Light Blue
                _buildCategoryCard(context, 'Mentorship', 'assets/Images/mentor.png', Color(0xFFFFF2CC)), // Light Yellow
                _buildCategoryCard(context, 'Entrepreneurship', 'assets/Images/enterpre.png', Color(0xFFE8D9F1)), // Light Purple
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "What We Offer?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 180, // Adjust height for images
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildOfferCard('Cultural Events and Conferences', 'assets/Images/corporate-college-quiz.jpg'),
                  _buildOfferCard('Mentorships', 'assets/Images/mentorships.png'),
                  _buildOfferCard('Scholarships', 'assets/Images/scholarships.jpg'),
                  _buildOfferCard('Start-up Support', 'assets/Images/start-up-support.jpg'),
                  _buildOfferCard('Advanced Salary', 'assets/Images/advance-salary.jpeg'),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Sharpen Your Coding Skills & Conquer Hiring Challenges",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildHorizontalImageCardWithText('assets/Images/corporate-college-quiz.jpg', 'Corporate Quiz'),
                  _buildHorizontalImageCardWithText('assets/Images/mentorships.png', 'Mentorship Programs'),
                  // _buildHorizontalImageCardWithText('assets/Images/project-financing.jpg', 'Projects'),

                ],
              ),
            ),

        ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: 200, // Adjust width as needed
              height: 180,
              fit: BoxFit.cover,
            ),
            Container(
              width: 200,
              height: 180,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalImageCardWithText(String imagePath, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.5),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String imagePath, Color bgColor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(title: title)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  class DetailScreen extends StatelessWidget {
  final String title;
  const DetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('Details for $title'),
      ),
    );
  }
}
