import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SessionDetails extends StatefulWidget {
  const SessionDetails({super.key});

  @override
  State<SessionDetails> createState() => _SessionDetailsState();
}

class _SessionDetailsState extends State<SessionDetails>
    with SingleTickerProviderStateMixin {
  final List<String> imgList = [
    'assets/istockphoto-1044168372-612x612.jpg',
    'assets/istockphoto-1044168372-612x612.jpg',
    'assets/istockphoto-1044168372-612x612.jpg',
    'assets/istockphoto-1044168372-612x612.jpg',
  ];

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final String imagePath = 'assets/istockphoto-1044168372-612x612.jpg';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(curvedAnimation);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Session Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xffb2c02c),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: imgList.map((item) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: 1000,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 40),
          SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xffb2c02c),
                    ),
                  ),
                  child: const Text(
                    'Join Sessions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDetailRow(
                        icon: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/images.jpeg'),
                        ),
                        text: 'Instructor: Steve Sherman',
                      ),
                      const SizedBox(height: 15),
                      buildDetailRow(
                        icon: const Icon(
                          Icons.laptop_chromebook,
                          color: Color(0xffb2c02c),
                        ),
                        text: 'No.of Meetups | 1',
                      ),
                      const SizedBox(height: 15),
                      buildDetailRow(
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Color(0xffb2c02c),
                        ),
                        text: '23-4-2024 | Tuesday',
                      ),
                      const SizedBox(height: 15),
                      buildDetailRow(
                        icon: const Icon(
                          Icons.punch_clock_outlined,
                          color: Color(0xffb2c02c),
                        ),
                        text: '4:30-7:00',
                      ),
                      const SizedBox(height: 15),
                      buildDetailRow(
                        icon: const Icon(
                          Icons.money,
                          color: Color(0xffb2c02c),
                        ),
                        text: '200\$',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath,
                  height: 300,
                  width: 380,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget buildDetailRow({required Widget icon, required String text}) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
