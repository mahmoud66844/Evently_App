import 'package:evently_app/ui/screens/login/login_screen.dart';
import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:evently_app/ui/utils/app_colors.dart';
import 'package:evently_app/ui/utils/app_styles.dart';
import 'package:evently_app/ui/widgets/evently_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(AppAssets.appLogo, width: 150),
        leading: _currentPage != 0
            ? IconButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                icon: const Icon(Icons.arrow_back_ios, color: Color(0xff0E3A99)),
              )
            : null,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text(
              'Skip',
              style: AppTextStyles.blue14SemiBold,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  const OnboardingPage(
                    imagePath: AppAssets.onboarding1,
                    title: 'Personalize Your Experience',
                    description:
                        'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
                    isFirstPage: true,
                  ),
                  const OnboardingPage(
                    imagePath: AppAssets.onboarding2,
                    title: 'Find Events That Inspire You',
                    description:
                        'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.',
                  ),
                  const OnboardingPage(
                    imagePath: AppAssets.onboarding3,
                    title: 'Effortless Event Planning',
                    description:
                        'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we\'ve got you covered. Plan with ease and focus on what matters - creating an unforgettable experience for you and your guests.',
                  ),
                  const OnboardingPage(
                    imagePath: AppAssets.onboarding4,
                    title: 'Connect with Friends & Share Moments',
                    description:
                        'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage >= index ? AppColors.blue : AppColors.grey2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            EventlyButton(
              text: _currentPage == 0
                  ? "Let's start"
                  : (_currentPage == 3 ? 'Get started' : 'Next'),
              onPress: () {
                if (_currentPage == 3) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool isFirstPage;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.isFirstPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const Spacer(),
          Image.asset(imagePath, height: MediaQuery.of(context).size.height * 0.3),
          const Spacer(),
          Text(
            title,
            style: AppTextStyles.black20SemiBold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: AppTextStyles.grey14Regular,
            textAlign: TextAlign.center,
          ),
          if (isFirstPage) const LanguageAndThemeSelectors(),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class LanguageAndThemeSelectors extends StatelessWidget {
  const LanguageAndThemeSelectors({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Language', style: AppTextStyles.blue24SemiBold),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.lightGrey)
                ),
                child: Row(
                  children: [
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                       decoration: BoxDecoration(
                         color: AppColors.blue,
                         borderRadius: BorderRadius.circular(20)
                       ),
                       child: const Text('English', style: AppTextStyles.white18Medium),
                     ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Text('Arabic', style: AppTextStyles.black14Medium),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Theme', style: AppTextStyles.blue24SemiBold),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.lightGrey)
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Icon(Icons.wb_sunny, color: AppColors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Icon(Icons.nightlight_round, color: AppColors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
