import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles.dart';

class HomeScreen extends StatefulWidget {
  final String internName;
  final String referralCode;
  final int totalDonations;

  const HomeScreen({
    Key? key,
    required this.internName,
    required this.referralCode,
    required this.totalDonations,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardPage(
        internName: widget.internName,
        referralCode: widget.referralCode,
        totalDonations: widget.totalDonations,
      ),
      const LeaderboardPage(),
      const AnnouncementsPage(),
    ];

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBE9E7), // 🟡 Premium Solid Background Color (change HEX if needed)
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'She Can Foundation',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            color: Colors.deepPurple, // ⬅️ Changed to dark text for light background
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/images/profile_placeholder.png'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.1),  // Slide from bottom
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white.withOpacity(0.9),
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.black54,
        elevation: 10,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events_rounded), label: 'Leaderboard'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign_rounded), label: 'Announcements'),
        ],
      ),
    );
  }
}



/// Dashboard Page (adapted for your styles)
class DashboardPage extends StatelessWidget {
  final String internName;
  final String referralCode;
  final int totalDonations;

  const DashboardPage({
    Key? key,
    required this.internName,
    required this.referralCode,
    required this.totalDonations,
  }) : super(key: key);

  final List<Map<String, String>> rewards = const [
    {"title": "Achievement Badge", "icon": "🏆", "desc": "Completed 5 campaigns"},
    {"title": "Referral Bonus", "icon": "🎁", "desc": "Shared with 10 friends"},
    {"title": "Top Donor", "icon": "💖", "desc": "Raised ₹5000+"},
    {"title": "Impact Creator", "icon": "🌟", "desc": "Helped 50 beneficiaries"},
    {"title": "Community Builder", "icon": "🤝", "desc": "Organized 3 offline events"},
    {"title": "Social Media Champ", "icon": "📣", "desc": "Promoted on Instagram 20 times"},
    {"title": "Volunteer Star", "icon": "✨", "desc": "Completed 20 volunteer hours"},
  ];


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hello, $internName 👋',
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              )),
          const SizedBox(height: 8),
          _glassContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Referral Code: $referralCode',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87)),
                const SizedBox(height: 8),
                Text('Total Donations',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54)),
                Text('₹$totalDonations',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: kAccentColor,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Your Rewards', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.purple)),
          const SizedBox(height: 12),
          SizedBox(
            height: 190,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: rewards.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final reward = rewards[index];
                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 500 + (index * 100)),
                  tween: Tween<Offset>(begin: Offset(0.2, 0), end: Offset.zero),
                  curve: Curves.easeOutBack,
                  builder: (context, Offset offset, child) {
                    return Transform.translate(
                      offset: Offset(offset.dx * 50, 0),
                      child: Opacity(opacity: 1.0 - offset.dx, child: child),
                    );
                  },
                  child: _rewardCard(reward['icon']!, reward['title']!, reward['desc']!),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
          Text('Support Women in Need',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w600, color: Colors.purple)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              // TODO: Navigate to donation page if needed
            },
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/images/women_in_poverty.jpg'), // Your Ad Image here
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.3), // Overlay for better text visibility
                ),
                alignment: Alignment.center,
                child: Text(
                  'Help Us Empower More Lives 💪',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _rewardCard(String icon, String title, String desc) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 36)),
          const SizedBox(height: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16, color: kPrimaryColor)),
                const SizedBox(height: 4),
                Text(desc,
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class RewardCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  const RewardCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFBE9E7), // lighter pink background
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFED6663).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 42)),
          const SizedBox(height: 12),
          Text(title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF4E89AE))),
          const SizedBox(height: 6),
          Text(description,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }
}


/// Leaderboard page
class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> leaderboardData = const [
    {
      "name": "Saavi Sagdeo",
      "donations": 8700,
      "image": "assets/images/img_1.jpg"
    },
    {
      "name": "Rahul Kumar",
      "donations": 6500,
      "image": "assets/images/img_2.png"
    },
    {
      "name": "Hridaya Khandrani",
      "donations": 5400,
      "image": "assets/images/img_4.png"
    },
    {
      "name": "Kratwish Sagdeo",
      "donations": 5000,
      "image": "assets/images/img_3.png"
    },
    {
      "name": "Sanya Mehta",
      "donations": 3800,
      "image": "assets/images/img_5.png"
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Top Fundraisers',
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Total Raised: ₹50,000 | Active Interns: 25',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: leaderboardData.length,
            itemBuilder: (context, index) {
              final item = leaderboardData[index];
              return TweenAnimationBuilder(
                duration: Duration(milliseconds: 500 + (index * 150)),
                tween: Tween<Offset>(begin: Offset(-0.3, 0), end: Offset.zero),
                curve: Curves.easeOutCubic,
                builder: (context, Offset offset, child) {
                  return Transform.translate(
                    offset: Offset(offset.dx * 50, 0),
                    child: Opacity(opacity: 1.0 - offset.dx.abs(), child: child),
                  );
                },
                child: _leaderboardCard(item['name'], item['donations'], index, item['image']),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _leaderboardCard(String name, int donations, int rank, String imagePath) {
    Color badgeColor;
    String badgeEmoji;

    switch (rank) {
      case 0:
        badgeColor = Colors.amber;
        badgeEmoji = '🥇';
        break;
      case 1:
        badgeColor = Colors.grey;
        badgeEmoji = '🥈';
        break;
      case 2:
        badgeColor = Colors.brown;
        badgeEmoji = '🥉';
        break;
      default:
        badgeColor = Colors.blueGrey;
        badgeEmoji = '${rank + 1}';
    }

    return GestureDetector(
      onTap: () {
        // Flip card or show bottom sheet for user impact details
        // (For demo, you can implement simple print or snackbar)
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: badgeColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(imagePath),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      badgeEmoji,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: donations / 10000,
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      color: badgeColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '₹$donations',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}


/// Announcements page
class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  final List<Map<String, String>> announcements = const [
    {
      "title": "🚨 Urgent: Flood Relief Volunteers Needed!",
      "description": "We need immediate volunteers for flood relief in Mumbai. Join us in making an impact today.",
      "date": "Aug 3, 2025",
      "type": "urgent"
    },
    {
      "title": "Weekly Progress Report Submission",
      "description": "Submit your progress report before Friday 5 PM to stay on track with your internship.",
      "date": "Aug 2, 2025",
      "type": "normal"
    },
    {
      "title": "Webinar on Social Impact",
      "description": "Join us for an exclusive webinar this Saturday on creating grassroots social impact.",
      "date": "Aug 5, 2025",
      "type": "upcoming"
    },
    {
      "title": "New Badges Unlocked!",
      "description": "Congrats to our top fundraisers for unlocking new achievement badges.",
      "date": "Aug 1, 2025",
      "type": "normal"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _stickyUrgentBanner(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final item = announcements[index];
              return _timelineAnnouncementCard(item);
            },
          ),
        ),
      ],
    );
  }

  Widget _stickyUrgentBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Colors.redAccent.withOpacity(0.85),
      child: Text(
        "🚨 Urgent: Flood Relief Volunteers Needed Today!",
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _timelineAnnouncementCard(Map<String, String> item) {
    bool isUrgent = item['type'] == 'urgent';
    bool isUpcoming = item['type'] == 'upcoming';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Dot & Line
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: isUrgent
                    ? Colors.red
                    : isUpcoming
                    ? Colors.orange
                    : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 100,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        const SizedBox(width: 16),
        // Announcement Card
        Expanded(
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item['title']!,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    ),
                  ),
                  if (isUrgent)
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text("URGENT",
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.red,
                              fontWeight: FontWeight.bold)),
                    ),
                  if (isUpcoming)
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text("UPCOMING",
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(item['date']!,
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Colors.black54)),
              ),
              children: [
                Text(item['description']!,
                    style: GoogleFonts.poppins(fontSize: 14)),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      // Action (you can link to detail page or form)
                    },
                    child: const Text("Know More"),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
