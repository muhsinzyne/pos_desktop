import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingUI {
  static Widget renderSkeleton(length) {
    List<Widget> animation = [];
    for (int i = 0; i < length; i++) {
      animation.add(skeletonWidget());
      animation.add(Divider());
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: animation,
      ),
    );
  }
}

Widget skeletonWidget() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SkeletonAnimation(
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Expanded(
        flex: 9,
        child: Container(
          height: 60,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              SkeletonAnimation(
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              SkeletonAnimation(
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
