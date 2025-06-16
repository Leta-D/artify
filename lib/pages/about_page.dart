import 'package:aaa/app_theme/app_colors.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBlack(1, context),
        foregroundColor: appWhite(1, context),
        centerTitle: true,
        title: Text(
          "About App",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            foreground:
                Paint()
                  ..shader = buttonGradient.createShader(
                    Rect.fromLTWH(0, 0.0, 360.0, 40),
                  ),
          ),
        ),
      ),
      backgroundColor: appBlack(1, context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Artify',
              style: TextStyle(
                color: appRed(1),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Artify is your ultimate wallpaper companion, designed to bring stunning visuals to your device with ease, flexibility, and personalization. Built with love using Flutter, Artify helps you explore, download, and set beautiful wallpapers effortlessly—whether from online collections or your local gallery.',
              style: TextStyle(color: appWhite(0.7, context), fontSize: 14),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Key Features',
                style: TextStyle(
                  color: appWhite(0.9, context),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildFeatureItem(
              context,
              'Explore by Categories',
              'Easily browse high-quality wallpapers categorized by themes to suit every mood and style.',
            ),
            _buildFeatureItem(
              context,
              'Smart Search',
              'Find exactly what you’re looking for with a powerful search that shows related images in seconds.',
            ),
            _buildFeatureItem(
              context,
              'Flexible Download Options',
              'Download wallpapers in the quality you prefer—optimized for your device and storage.',
            ),
            _buildFeatureItem(
              context,
              'Set as Wallpaper',
              'Apply wallpapers directly to your Home Screen, Lock Screen, or Both with a single tap.',
            ),
            _buildFeatureItem(
              context,
              'Unsplash Integration',
              'Get access to thousands of free and breathtaking wallpapers from Unsplash, right inside Artify.',
            ),
            _buildFeatureItem(
              context,
              'Local Gallery Support',
              'Use your own images from your device’s gallery and set them as wallpapers too.',
            ),
            _buildFeatureItem(
              context,
              'Manage Downloads',
              'View, filter, and delete wallpapers you’ve downloaded using Artify. Clean up your gallery easily.',
            ),
            _buildFeatureItem(
              context,
              'Dark & Light Mode',
              'Customize your viewing experience by switching between light and dark themes anytime.',
            ),
            _buildFeatureItem(
              context,
              'Vibration Control',
              'Enable or disable haptic feedback based on your personal preference.',
            ),
            const SizedBox(height: 24),
            Text(
              'Whether you\'re looking to refresh your device’s look or express your personality, Artify gives you the control and creativity to do it your way.',
              style: TextStyle(color: appWhite(0.7, context)),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '🌟 Thanks for using my app 🌟',
                  style: TextStyle(color: appWhite(1, context), fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16, color: appWhite(0.7, context)),
          children: [
            TextSpan(
              text: '• $title: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: description, style: TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

// class AboutPage extends StatelessWidget {
//   const AboutPage({super.key});

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('About Artify'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Artify',
//               style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Artify is your ultimate wallpaper companion, designed to bring stunning visuals to your device with ease, flexibility, and personalization. Built with love using Flutter, Artify helps you explore, download, and set beautiful wallpapers effortlessly—whether from online collections or your local gallery.',
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             const SizedBox(height: 24),
//             Text(
//               '🌟 Key Features',
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                     fontWeight: FontWeight.w600,
//                   ),
//             ),
//             const SizedBox(height: 12),
//             _buildFeatureItem('Explore by Categories', 'Easily browse high-quality wallpapers categorized by themes to suit every mood and style.'),
//             _buildFeatureItem('Smart Search', 'Find exactly what you’re looking for with a powerful search that shows related images in seconds.'),
//             _buildFeatureItem('Flexible Download Options', 'Download wallpapers in the quality you prefer—optimized for your device and storage.'),
//             _buildFeatureItem('Set as Wallpaper', 'Apply wallpapers directly to your Home Screen, Lock Screen, or Both with a single tap.'),
//             _buildFeatureItem('Unsplash Integration', 'Get access to thousands of free and breathtaking wallpapers from Unsplash, right inside Artify.'),
//             _buildFeatureItem('Local Gallery Support', 'Use your own images from your device’s gallery and set them as wallpapers too.'),
//             _buildFeatureItem('Manage Downloads', 'View, filter, and delete wallpapers you’ve downloaded using Artify. Clean up your gallery easily.'),
//             _buildFeatureItem('Dark & Light Mode', 'Customize your viewing experience by switching between light and dark themes anytime.'),
//             _buildFeatureItem('Vibration Control', 'Enable or disable haptic feedback based on your personal preference.'),
//             const SizedBox(height: 24),
//             Text(
//               'Whether you\'re looking to refresh your device’s look or express your personality, Artify gives you the control and creativity to do it your way.',
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeatureItem(String title, String description) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: RichText(
//         text: TextSpan(
//           style: const TextStyle(fontSize: 16, color: Colors.black87),
//           children: [
//             TextSpan(
//               text: '• $title: ',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             TextSpan(text: description),
//           ],
//         ),
//       ),
//     );
//   }
// }
