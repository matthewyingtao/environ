import 'package:environ/screens/lessons/info_card.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Lessons',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          const SizedBox(height: 12),
          const InfoCard(
            heading: 'Paper & Cardboard',
            body:
                '''This includes: \n• Newspapers and magazines \n• Corrugated cardboard \n• Office paper''',
            icon: Icons.description_rounded,
            imagePath: 'assets/trash_category/cardboard.jpg',
          ),
          const InfoCard(
            heading: 'Glass',
            body:
                '''This includes: \n• Bottles, jars and containers \n• Clear and colored Glass''',
            icon: Icons.liquor_rounded,
            imagePath: 'assets/trash_category/glass.jpg',
          ),
          const InfoCard(
            heading: 'Metal',
            body: 'This includes: \n• Aluminium and tin cans \n• Aerosols',
            icon: Icons.iron_rounded,
            imagePath: 'assets/trash_category/metal.jpg',
          ),
          const InfoCard(
            heading: 'Plastic',
            body:
                '''This includes: \n• Milk and drink bottles \n• Plastic shrink wrap''',
            icon: Icons.casino_rounded,
            imagePath: 'assets/trash_category/plastic.jpg',
          ),
          const InfoCard(
            heading: 'Reducing Waste',
            body:
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
            icon: Icons.delete,
            imagePath: 'assets/trash_category/trash.jpg',
          ),
          const SizedBox(height: 24),
        ],
      );
}
