import 'package:flutter/material.dart';
import 'package:rekruters/Screens/Loginscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async'; // Import Timer
import 'package:url_launcher/url_launcher.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);


  @override
  State<Dashboard> createState() => _DashboardState();
}

Future<String?> _getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userName');
}


class _DashboardState extends State<Dashboard> {
  String? userName;

  final PageController _controller = PageController(viewportFraction: 1.0);
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 0;
  Timer? _timer;
  double _scrollPosition = 0.0;


  Future<void> _loadUserName() async {
    String? name = await _getUserName();
    setState(() {
      userName = name;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _startAutoScroll();
    _startPageScroll();
  }

  final List<Map<String, String>> offers = [
    {
      'title': 'Cultural Event and Conference',
      'image': 'assets/Images/corporate-college-quiz.jpg'
    },
    {'title': 'Mentorships', 'image': 'assets/Images/mentorships.png'},
    {'title': 'Scholarships', 'image': 'assets/Images/scholarships.jpg'},
    {
      'title': 'Start-up Support',
      'image': 'assets/Images/start-up-support.jpg'
    },
    {'title': 'Cultural Events and Conference', 'image': 'assets/Images/banquets-banner.jpg'},




    {'title': 'Competitive Assessments', 'image': 'assets/Images/competitive-assessments.jpg'},


    {'title': 'Advanced Salary', 'image': 'assets/Images/advance-salary.jpeg'},
  ];
  final List<Map<String, String>> items = [
    {'image': 'assets/Images/project-financing.jpg', 'title': 'Projects'},
    {'image': 'assets/Images/skills.jpg', 'title': 'SKill Assesment'},
    {'image': 'assets/Images/web-development.png', 'title': 'Coding Practice'},
    {'image': 'assets/Images/learning-community.jpg', 'title': 'Interview Preparation'},



  ];


  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_controller.hasClients) { // ✅ Check if it's attached
        if (_currentPage < offers.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _controller.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel(); // ✅ Stop the timer if the controller is not attached
      }
    });
  }


  void _startPageScroll() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_scrollController.hasClients) { // ✅ Ensure controller is attached
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        double itemWidth = MediaQuery.of(context).size.width * 0.9 + 10; // Card width + spacing

        setState(() {  // ✅ Ensure UI updates
          if (_scrollPosition + itemWidth <= maxScrollExtent) {
            _scrollPosition += itemWidth; // Move exactly one item
          } else {
            _scrollPosition = 0; // Reset when reaching the end
          }
        });

        _scrollController.animateTo(
          _scrollPosition,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel(); // ✅ Stop if the controller is not attached
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                            MaterialPageRoute(
                                builder: (context) => CandidateLoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          // A richer blue color
                          foregroundColor: Colors.white,
                          // White text for contrast
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          // Better padding
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
                    'Hey, ${userName ?? 'User'}',
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
                  'We Provide',
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
                _buildCategoryCard(
                    context, 'Practice', 'assets/Images/practice.png',
                    Color(0xFFFFE4B5), 'Sharpen Your Skills',
                    'https://rekruters.com/Practice.aspx'),
                _buildCategoryCard(
                    context, 'Job Opportunities', 'assets/Images/job.png',
                    Color(0xFFDFFFD6), 'Find Your Dream Job',
                    'https://rekruters.com/Jobs.aspx'),
                _buildCategoryCard(
                    context, 'Internships', 'assets/Images/intern.png',
                    Color(0xFFF5D0C5), 'Gain Real-World Experience',
                    'https://rekruters.com/Internship.aspx'),
                _buildCategoryCard(
                    context, 'Competitions', 'assets/Images/compete.png',
                    Color(0xFFD6E4FF), 'Test Your Abilities',
                    'https://rekruters.com/Compete.aspx'),
                _buildCategoryCard(
                    context, 'Mentorship', 'assets/Images/mentor.png',
                    Color(0xFFFFF2CC), 'Learn from the Best',
                    'https://rekruters.com/Mentorship.aspx'),
                _buildCategoryCard(
                    context, 'Entrepreneurship', 'assets/Images/enterpre.png',
                    Color(0xFFE8D9F1), 'Turn Ideas into Reality',
                    'https://rekruters.com/Entrepreneurship.aspx'),
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
              height: 180, // Increased height for better display
              width: double.infinity, // Full screen width
              child: PageView.builder(
                controller: _controller,
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  return _buildOfferCard(
                      offers[index]['title']!, offers[index]['image']!,context);
                },
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
              height: 180, // Match height with _buildOfferCard
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5), // Add spacing to match calculation
                    child: _buildHorizontalImageCardWithText(
                      items[index]['image']!,
                      items[index]['title']!,
                      context, // Pass context here
                    ),
                  );
                },
              ),
            )



          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(String title, String imagePath, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Rounded corners
        child: Stack(
          children: [
            // Background Image
            Image.asset(
              imagePath,
              width: MediaQuery.of(context).size.width * 0.9,
              height: 180,
              fit: BoxFit.cover,
            ),

            // Gradient Overlay for better readability
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 180, // Ensure it covers the entire image
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            // Text Positioned at the Bottom
            Positioned(
              bottom: 15, // Adjust for better placement
              left: 0,
              right: 0,
              child: Text(
                title.toUpperCase(), // Styled text
                style: TextStyle(
                  fontSize: 16, // Same font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.8), // Dark glow effect
                      offset: Offset(2, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalImageCardWithText(String imagePath, String title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10), // Same padding as _buildOfferCard
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Same rounded corners
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: MediaQuery.of(context).size.width * 0.9, // Ensure same width
              height: 180, // Same height as _buildOfferCard
              fit: BoxFit.cover, // Ensure it fully covers the area
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9, // Match width
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child:  Text(
                title.toUpperCase(), // Match title styling from horizontal card
                style: TextStyle(
                  fontSize: 16, // Same font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2, // Uniform spacing for better appearance
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCategoryCard(BuildContext context, String title, String imagePath, Color bgColor, String subtitle, String url) {
    return GestureDetector(
      onTap: () async {
        final Uri _url = Uri.parse(url.toString());launchUrl(_url);
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Could not open $title')),
          // );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 60),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildStandardCard(String title, String imagePath, {Color? bgColor}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 200,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: bgColor ?? Colors.white,
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
              width: 200,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 200,
            height: 180,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
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
