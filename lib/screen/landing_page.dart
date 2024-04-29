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
      title: 'Anifetch,',
      description:
          'fill your list with brand new content. \n Get a random anime to add to your watching list.',
      imageUrl:
          'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/197053ad-5569-468b-9a44-9685546c3285/dcjg90g-1463173b-87bb-430e-84d8-3c469915861d.png/v1/fit/w_828,h_850/dragon_ball_png_by_irfanabbasi_dcjg90g-414w-2x.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MzQzOCIsInBhdGgiOiJcL2ZcLzE5NzA1M2FkLTU1NjktNDY4Yi05YTQ0LTk2ODU1NDZjMzI4NVwvZGNqZzkwZy0xNDYzMTczYi04N2JiLTQzMGUtODRkOC0zYzQ2OTkxNTg2MWQucG5nIiwid2lkdGgiOiI8PTMzNTEifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.3DiRNigMAlqfne0wUXesoaRzIRNUGKuAINXzanqS1mU',
      bgColor: const Color(0xfffeae4f),
    ),
    OnboardingPageModel(
      title: 'Discover the depths of the \n japanese culture.',
      description:
          'Go from the lightest easy-going school-life stories, to the darkest gore fantasy story there is.',
      imageUrl:
          'https://i.pinimg.com/originals/8e/91/44/8e9144af5fdec0c9fd9a9d60dccc01b5.png',
      bgColor: Colors.black,
    ),
    OnboardingPageModel(
      title: 'Dive back in your childhood',
      description:
          'You will find here stuff that you might have even forgotten about. Be prepared !',
      imageUrl:
          'https://i.ibb.co/12ZrdWD/png-clipart-gengar-haunter-pokemon-sun-and-moon-pokedex-gengar-purple-violet-removebg-preview.png',
      bgColor: const Color.fromRGBO(90, 57, 104, 1),
      //https://api.flutter.dev/flutter/dart-ui/Color-class.html
    ),
    OnboardingPageModel(
      title: 'Get retro\'ed !',
      description:
          'This app includes of course retro stuff you\'d not expect to stumble on',
      imageUrl:
          'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/d09ac73d-eb31-448c-beb7-5cae85e4df26/dc6ww9b-55cdc595-c39b-478b-b436-3a87ec2a66f7.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2QwOWFjNzNkLWViMzEtNDQ4Yy1iZWI3LTVjYWU4NWU0ZGYyNlwvZGM2d3c5Yi01NWNkYzU5NS1jMzliLTQ3OGItYjQzNi0zYTg3ZWMyYTY2ZjcucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.3L5elcRJoH1wvjvhl3uilwYHwscrz0P77m6dUF5KDgA',
      bgColor: Colors.red,
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
                // PageView to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (idx) {
                    // Change current page when pageView changes
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
