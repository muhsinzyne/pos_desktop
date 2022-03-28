import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class CCachedNetworkImage extends StatelessWidget {
  const CCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.fit,
    this.width = 100,
    this.height = 100,
  }) : super(key: key);

  final String imageUrl;
  final BoxFit? fit;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      placeholder: (context, url) => Container(
        child: Center(
          child: SpinKitDoubleBounce(
            color: AppColors.primary,
            size: width / 2,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.white,
        child: Image.asset('assets/images/no-image.png'),
      ),
    );
  }
}
