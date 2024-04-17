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
        'https://t2.gstatic.com/licensed-image?q=tbn:ANd9GcShMUjTSwesw4HCPw4DMsnJh-P-LZ48HxAliBMoZAxYgrUujXnpbFHeOyM06Aer0yP-',
    headline: 'Breaking News: Flutter is Amazing!',
    linkUrl: 'https://example.com/news1',
  ),
  NewsItem(
    imageUrl:
        'https://t2.gstatic.com/licensed-image?q=tbn:ANd9GcShMUjTSwesw4HCPw4DMsnJh-P-LZ48HxAliBMoZAxYgrUujXnpbFHeOyM06Aer0yP-',
    headline: 'New Study Shows Benefits of Flutter Development',
    linkUrl: 'https://example.com/news2',
  ),
  NewsItem(
    imageUrl:
        'https://t2.gstatic.com/licensed-image?q=tbn:ANd9GcShMUjTSwesw4HCPw4DMsnJh-P-LZ48HxAliBMoZAxYgrUujXnpbFHeOyM06Aer0yP-',
    headline: 'Flutter 3.0 Release Announced',
    linkUrl: 'https://example.com/news3',
  ),
];
