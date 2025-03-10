import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0; // Tracks current image index

  // List of images for the carousel
  final List<String> carouselImages = [
    "assets/banner1.webp",
    "assets/banner2.jpg",
    "assets/banner3.jpg",
  ];

  // List of toy items for the grid
  final List<Map<String, String>> toys = [
    {"name": "Teddy Bear", "image": "assets/teddy.webp"},
    {"name": "Race Car", "image": "assets/toy_car.jpg"},
    {"name": "Lego Set", "image": "assets/toy_lego.jpg"},
    {"name": "Doll", "image": "assets/toy_doll.jpg"},
    {"name": "Robot", "image": "assets/toy_robot.jpg"},
    {"name": "Train Set", "image": "assets/toy_train.webp"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 4, // Adds shadow effect

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/timeless_logo.jpg",
              height: 40,
            ),
            const Text(
              "Timeless Toys",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart, size: 28, color: Colors.white),
              onPressed: () {
                // Navigate to Shopping Cart Page (Placeholder for now)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Shopping Cart Clicked")),
                );
              },
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider.builder(
                itemCount: carouselImages.length,
                options: CarouselOptions(
                  height: 180, // Carousel height
                  autoPlay: true, // Auto-play images
                  autoPlayInterval: const Duration(seconds: 3), // Time per slide
                  enlargeCenterPage: true, // Zoom effect
                  viewportFraction: 0.9, // Visible portion of next image
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      carouselImages[index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 10, // Adjust position
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: carouselImages.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey.shade300,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: toys.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Clicked on ${toys[index]['name']}")),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                toys[index]["image"]!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              toys[index]["name"]!,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
