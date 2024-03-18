import 'package:flutter/material.dart';
import 'package:flutter_rest_api/screen/list_screen.dart';

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

  @override
  _OnboardingPage1State createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1> {
  final List<OnboardingPageModel> _pages = [
    OnboardingPageModel(
      title: 'Anime App - landing page',
      description: 'Get a random anime to add to your watching list.',
      imageUrl: 'https://i.ibb.co/vcJzJHf/gojo-render-removebg-preview.png',
      bgColor: Colors.indigo,
    ),
    OnboardingPageModel(
      title: 'Connect with your friends.',
      description: 'Connect with your friends anytime anywhere.',
      imageUrl: 'https://picsum.photos/200/300',
      bgColor: const Color(0xff1eb090),
    ),
    OnboardingPageModel(
      title: 'Bookmark your favourites',
      description: 'Bookmark your favourite quotes to read at a leisure time.',
      imageUrl: 'https://i.ibb.co/420D7VP/building.png',
      bgColor: const Color(0xfffeae4f),
    ),
    OnboardingPageModel(
      title: 'Follow creators',
      description: 'Follow your favourite creators to stay in the loop.',
      imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
      bgColor: Colors.purple,
    ),
  ];

  // Store the currently visible page
  int _currentPage = 0;

  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: _pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (idx) {
                    // Change current page when pageview changes
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = _pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.network(
                              item.imageUrl,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: item.textColor,
                                        )),
                              ),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          color: item.textColor,
                                        )),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _pages
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == _pages.indexOf(item) ? 30 : 8,
                          height: 8,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                        ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          visualDensity: VisualDensity.comfortable,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        // Implement your logic for Skip button here
                      },
                      // child: TextButton(
                      //     style: TextButton.styleFrom(
                      //       foregroundColor: const Color(0xFF6200EE),
                      //     ),
                      //     onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => const SecondRoute()),
                      //       );
                      //     })
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListScreen()),
                          );
                        },
                        child: const Text('Get to the app'),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          visualDensity: VisualDensity.comfortable,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          _currentPage = -1;
                          // Implement your logic for Finish button here
                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            _currentPage == _pages.length - 1
                                ? "Restart"
                                : "Next",
                          ),
                          const SizedBox(width: 8),
                          Icon(_currentPage == _pages.length - 1
                              ? Icons.done
                              : Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String imageUrl;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel(
      {required this.title,
      required this.description,
      required this.imageUrl,
      this.bgColor = Colors.blue,
      this.textColor = Colors.white});
}
