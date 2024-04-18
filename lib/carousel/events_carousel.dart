import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsCarousel extends StatelessWidget {
  final List<EventItem> eventItems;

  EventsCarousel({required this.eventItems});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150, // Reduced height
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        scrollPhysics: BouncingScrollPhysics(), // Add bounce effect
        pageSnapping: true, // Snap to page while scrolling
      ),
      items: eventItems.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
             onTap: () async {
                final Uri _url = Uri.parse(item.eventLink);
                try {
                  await launchUrl(_url);
                } catch (e) {
                  Fluttertoast.showToast(msg: 'Error');
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            item.eventName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0, // Reduced font size
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class EventItem {
  final String imageUrl;
  final String eventName;
  final String eventLink;

  EventItem(
      {required this.imageUrl,
      required this.eventName,
      required this.eventLink});
}

List<EventItem> eventItems = [
  EventItem(
    imageUrl: 'https://images.app.goo.gl/PL9JysPZPeuHxj2J8',
    eventName: 'Earth Day Celebration',
    eventLink: 'https://example.com/event1',
  ),
  EventItem(
    imageUrl: 'https://images.app.goo.gl/W7nTFC8Hm42hjGsM9',
    eventName: 'Zero Waste Week',
    eventLink: 'https://example.com/event2',
  ),
  EventItem(
    imageUrl: 'https://images.app.goo.gl/qD3SU8Jy7vAvTpYk6',
    eventName: 'Green Energy Expo',
    eventLink: 'https://example.com/event3',
  ),
  EventItem(
    imageUrl: 'https://images.app.goo.gl/EeLzUP47hnTvukMb7',
    eventName: 'Bike to Work Day',
    eventLink: 'https://example.com/event4',
  ),
  
];
