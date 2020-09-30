import 'dart:async';
import 'dart:math';
import 'package:extended_image/extended_image.dart';
/// @description
/// @Created by huang
/// @Date   2020/4/1
/// @email  a12162266@163.com

import 'package:flutter/material.dart';

class PhotoPlay extends StatefulWidget {
  final List pics;
  final int index;

  PhotoPlay({Key key, this.pics, this.index,})
      : super(key: key);

  @override
  PhotoPlayState createState() => new PhotoPlayState();
}

class PhotoPlayState extends State<PhotoPlay> {
  final rebuildIndex = StreamController<int>.broadcast();
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ExtendedImageSlidePage(
      slideAxis: SlideAxis.both,
      slideType: SlideType.onlyImage,
      child: Material(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: ExtendedImageGesturePageView.builder(
          controller: PageController(
            initialPage: widget.index,
          ),
          itemBuilder: (BuildContext context, int index) {
            var item = widget.pics[index];
            return GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: ExtendedImage.network(
                item,
                enableSlideOutPage: true, //开启滑动退出页面效果
                fit: BoxFit.contain,
                mode: ExtendedImageMode.gesture,
                heroBuilderForSlidingPage: (Widget result){
                  //Hero动画效果
                  return Hero(
                    tag: widget.pics[widget.index],
                    child: result,
                    flightShuttleBuilder: (BuildContext flightContext,
                        Animation<double> animation,
                        HeroFlightDirection flightDirection,
                        BuildContext fromHeroContext,
                        BuildContext toHeroContext) {
                      final Hero hero = (flightDirection == HeroFlightDirection.pop
                          ? fromHeroContext.widget
                          : toHeroContext.widget) as Hero;
                      return hero.child;
                    },
                  );
                },
                initGestureConfigHandler: (ExtendedImageState state) {
                  //大图自适应放大
                  double initialScale = 1.0;
                  if (state.extendedImageInfo != null && state.extendedImageInfo.image != null) {
                    initialScale = initScale(
                        size: size,
                        initialScale: initialScale,
                        imageSize: Size(
                            state.extendedImageInfo.image.width.toDouble(),
                            state.extendedImageInfo.image.height.toDouble()));
                  }
                  return GestureConfig(
                    inPageView: true,
                    initialScale: initialScale,
                    maxScale: max(initialScale, 5.0),
                    animationMaxScale: max(initialScale, 5.0),
                    initialAlignment: InitialAlignment.topCenter,
                    //you can cache gesture state even though page view page change.
                    //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                    cacheGesture: false,
                  );
                },
              ),
            );
          },
          itemCount: widget.pics.length,
          onPageChanged: (int index) {
            _currentIndex = index;
            rebuildIndex.add(index);
          },
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }

  double initScale({Size imageSize, Size size, double initialScale}) {
    final double n1 = imageSize.height / imageSize.width;
    final double n2 = size.height / size.width;
    if (n1 > n2) {
      final FittedSizes fittedSizes =
      applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      final Size destinationSize = fittedSizes.destination;
      return size.width / destinationSize.width;
    } else if (n1 / n2 < 1 / 4) {
      final FittedSizes fittedSizes =
      applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      final Size destinationSize = fittedSizes.destination;
      return size.height / destinationSize.height;
    }
  
    return initialScale;
  }

  @override
  void dispose() {
    rebuildIndex.close();
    super.dispose();
  }
}
