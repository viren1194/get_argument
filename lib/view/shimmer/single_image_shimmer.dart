import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class singleImageShimmer extends StatelessWidget {
  const singleImageShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
