import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  List<String> thumbnailList = [];
  Carousel({Key? key, this.thumbnailList = const []}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<Image> _carouselImgList = [];
  int _currentIndex = 0;
  //캐로셀 이미지 추가

  Future<List<Image>> getThumbnails(List<String> thumbnailList) async {
    List<Image> list = [];
    if (thumbnailList.isNotEmpty) {
      for (String url in thumbnailList) {
        list.add(Image.network(url));
      }
    } else {
      list.add(Image(
        image: AssetImage("assets/images/thumbnail.png"),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Image>>(
      future: getThumbnails(Carousel().thumbnailList),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            _carouselImgList = snapshot.data as List<Image>;
            return Stack(
              children: [
                CarouselSlider(
                  items: _carouselImgList,
                  options: CarouselOptions(
                    autoPlay: _carouselImgList.length == 1 ? false : true,
                    viewportFraction: 1.0,
                    height: 494.5.h,
                    onPageChanged: (index, reason) {
                      setState(
                        () {
                          _currentIndex = index;
                        },
                      );
                    },
                    pageSnapping: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                  ),
                ),
                Positioned(
                    child: Container(
                  color: Color(0xFF3c2107).withOpacity(0.3),
                  height: 494.5.h,
                )),
                Positioned(
                  height: 432.h,
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    child: Align(
                      alignment: Alignment(1.0, 1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _carouselImgList.map((urlOfItem) {
                          int index = _carouselImgList.indexOf(urlOfItem);
                          return Container(
                            width: _currentIndex == index ? 30.0.w : 10.0.w,
                            height: 10.0.h,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0.w, horizontal: 2.0.h),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: _currentIndex == index
                                  ? Color.fromRGBO(255, 255, 255, 0.8)
                                  : Color.fromRGBO(255, 255, 255, 0.3),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
