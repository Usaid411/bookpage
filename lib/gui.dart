import 'package:flutter/material.dart';
import 'package:bookpage/session_details.dart';

class BookedSessions extends StatefulWidget {
  const BookedSessions({super.key});

  @override
  State<BookedSessions> createState() => _BookedSessionsState();
}

class _BookedSessionsState extends State<BookedSessions>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    // Initialize controllers and animations for each session tile
    _controllers = List.generate(6, (index) {
      return AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      )..forward(); // Start animation immediately
    });

    // Slide and fade animations for each controller
    _slideAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
    }).toList();

    _fadeAnimations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0, // Set fade to 1.0 for fully visible
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ));
    }).toList();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget sessionTile(int index, String title, String instructor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SessionDetails()),
        );
      },
      child: FadeTransition(
        opacity: _fadeAnimations[index],
        child: SlideTransition(
          position: _slideAnimations[index],
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9, // Responsive width
            height: 100,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(111, 121, 200, 236),
            ),
            child: Row(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/istockphoto-1044168372-612x612.jpg',
                      width: 120,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Instructor: $instructor',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Booked Sessions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xffb2c02c),
              ),
            ),
            const Text(
              'Sessions: 6',
              style: TextStyle(color: Color(0xffb2c02c), fontSize: 15),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sessionTile(0, 'Living Maths Grade 4 - 5', 'Steve Sherman'),
              sessionTile(1, 'Introduction to Coding', 'Jane Doe'),
              sessionTile(2, 'Creative Writing Workshop', 'Emily Johnson'),
              sessionTile(3, 'Science Experiments for Kids', 'Dr. Mark Wilson'),
              sessionTile(4, 'Photography Basics', 'Alex Turner'),
              sessionTile(5, 'Music Theory for Beginners', 'Sarah Lee'),
            ],
          ),
        ),
      ),
    );
  }
}
