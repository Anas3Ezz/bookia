import 'package:bookia/core/widgets/customr_app_button.dart';
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const _CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: const [
              SizedBox(height: 20),
              _BookCoverImage(),
              SizedBox(height: 25),
              _BookTitles(),
              SizedBox(height: 20),
              _BookDescription(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _BottomActionBar(),
    );
  }
}

// --- Small Widgets ---

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark_border_rounded, color: Colors.black),
          onPressed: () {},
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BookCoverImage extends StatelessWidget {
  const _BookCoverImage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          'https://codingarabic.online/storage/product/l0kkykSGLKfrE90Vkah6LD8briUKwp0V5nvPvEI1.jpg', // Replace with your local asset
          height: 350,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _BookTitles extends StatelessWidget {
  const _BookTitles();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Black Heart',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Broché',
          style: TextStyle(
            fontSize: 18,
            color: const Color(0xffB9935E),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _BookDescription extends StatelessWidget {
  const _BookDescription();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        height: 1.6,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '₹285',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: AppButton(
              text: 'Add TO Cart',
              onPressed: () {
                // Your logic here
              },
              isFilled: true, // Ensures there's no border
              backgroundColor: Colors.black,
              textColor: Colors.white,
            ),
          ),
          // Expanded(
          //   child: SizedBox(
          //     height: 55,
          //     child: ElevatedButton(
          //       onPressed: () {},
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: const Color(0xff2F2F2F),
          //         foregroundColor: Colors.white,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         elevation: 0,
          //       ),
          //       child: const Text(
          //         'Add To Cart',
          //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
