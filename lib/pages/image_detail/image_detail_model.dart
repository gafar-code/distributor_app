import '/flutter_flow/flutter_flow_util.dart';
import 'image_detail_widget.dart' show ImageDetailWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageDetailModel extends FlutterFlowModel<ImageDetailWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Carousel widget.
  CarouselController? carouselController;
  int carouselCurrentIndex = 1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
