import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/18
/// @email  a12162266@163.com

class Skeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Shimmer.fromColors(
        period: Duration(milliseconds: 3000),
        baseColor: Colors.grey[600],
        highlightColor: Color(0xFFF9F9F9),
       child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(12, 16, 12, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 58,
                            margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 58,
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 9),
              padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 24),
                  ),
                  GridView.builder(
                    //禁用滑动
                    physics: NeverScrollableScrollPhysics(),
                    //列表内容的大小不固定, 为true则滚动视图将扩展到允许的最大大小, 如果是无界约束，则 shrinkWrap 必须为 true
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, //一行的item个数
                        childAspectRatio: 1.4 //item的宽高比
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            height: 28,
                            width: 28,
                            color: Colors.white,
                            // color: AppColors.Grey_F9,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            height: 6,
                            width: 28,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 24),
                  ),
                  GridView.builder(
                    //禁用滑动
                    physics: NeverScrollableScrollPhysics(),
                    //列表内容的大小不固定, 为true则滚动视图将扩展到允许的最大大小, 如果是无界约束，则 shrinkWrap 必须为 true
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, //一行的item个数
                        childAspectRatio: 1.4 //item的宽高比
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            height: 28,
                            width: 28,
                            color: Colors.yellow,
                            // color: AppColors.Grey_F9,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            height: 6,
                            width: 28,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // color: AppColors.Grey_F9,
                                borderRadius: BorderRadius.circular(6)
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
