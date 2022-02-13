import 'package:sportconnect/constants/app_images.dart';

class WalkThroughItem {
  final String title;
  final String subtitle;
  final String image;

  const WalkThroughItem({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

class WalkThroughItems {
  static List<WalkThroughItem> loadWalkThroughItem() {
    const item = <WalkThroughItem>[
      WalkThroughItem(
        title: 'Love Football?',
        subtitle:
            'Meet folks who will help fuel your love for football with latest gists',
        image: AppImages.onboardingFootball,
      ),
      WalkThroughItem(
        title: 'What about Basketball?',
        subtitle:
            'You can always get to meet friends who will make basketball so much fun for you',
        image: AppImages.onboardingBasketball,
      ),
      WalkThroughItem(
        title: 'Is there any for Rugby?',
        subtitle:
            'You\'re not alone. We have you covered. Your folks are waiting for you',
        image: AppImages.onboardingRugby,
      ),
      WalkThroughItem(
        title: 'Is that all?',
        subtitle:
            'Long story short, we have all the fun and gist for you in any sport',
        image: AppImages.onboardingAllSports,
      ),
    ];
    return item;
  }
}
