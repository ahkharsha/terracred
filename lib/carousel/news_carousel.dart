import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCarousel extends StatelessWidget {
  final List<NewsItem> newsItems;

  NewsCarousel({required this.newsItems});

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
      items: newsItems.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () async {
                final Uri _url = Uri.parse(item.linkUrl);
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
                            item.headline,
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

class NewsItem {
  final String imageUrl;
  final String headline;
  final String linkUrl;

  NewsItem(
      {required this.imageUrl, required this.headline, required this.linkUrl});
}

List<NewsItem> newsItems = [
  NewsItem(
    imageUrl:
        'https://images.app.goo.gl/cJxR8oMcypnq6SRg9',
    headline: 'City Implements New Recycling Program to Reduce Waste and Promote Sustainability',
    linkUrl: 'https://example.com/news1',
  ),
  NewsItem(
    imageUrl:
        'https://images.app.goo.gl/M4Urb8mPN9xacsAc6',
    headline: 'Government Announces Plan to Invest in Green Infrastructure for Renewable Energy Expansion',
    linkUrl: 'https://example.com/news2',
  ),
  NewsItem(
    imageUrl:
        'https://images.app.goo.gl/suwgfttD29NbG7Xo7',
    headline: 'Tech Company Launches Eco-Friendly Packaging Solution to Reduce Plastic Waste',
    linkUrl: 'https://example.com/news3',
  ),
  NewsItem(
    imageUrl:
        'https://images.app.goo.gl/HEyHTjATDqokeC7B6',
    headline: 'International Collaboration Leads to Historic Agreement on Climate Change Mitigation',
    linkUrl: 'https://example.com/news4',
  ),
  NewsItem(
    imageUrl:
        'https://t2.gstatic.com/licensed-image?q=tbn:ANd9GcShMUjTSwesw4HCPw4DMsnJh-P-LZ48HxAliBMoZAxYgrUujXnpbFHeOyM06Aer0yP-',
    headline: 'Local Community Rallies Together to Restore Urban Green Spaces',
    linkUrl: 'https://example.com/news5',
  ),
];
