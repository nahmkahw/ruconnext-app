import 'package:th.ac.ru.uSmart/hotel_booking/hotel_app_theme.dart';
import 'package:th.ac.ru.uSmart/pages/ru_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../model/mr30_model.dart';
import '../providers/mr30_provider.dart';
import '../utils/custom_functions.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';

class StudyListView extends StatelessWidget {
  const StudyListView(
      {Key? key,
      this.index,
      this.record,
      this.hotelData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);
  final int? index;
  final RECORD? record;
  final VoidCallback? callback;
  final HotelListData? hotelData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    String hotel = 'hotel_3';
    var havetoday = context.watch<MR30Provider>();
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 4,
                              child: Image.asset(
                                'assets/hotel/${record!.courseRoom.toString().trim().substring(0, 3)}.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: HotelAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${record!.courseNo}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  //hotelData!.subTxt,
                                                  '${record!.dayNameS} ${record!.timePeriod}',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.locationDot,
                                                  size: 12,
                                                  color: HotelAppTheme
                                                          .buildLightTheme()
                                                      .primaryColor,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RuMap()),
                                                    );
                                                  },
                                                  child: Text(
                                                    //'${hotelData!.dist.toStringAsFixed(1)} km to city',
                                                    '${record!.courseRoom}',

                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                                255, 4, 85, 205)
                                                            .withOpacity(0.8)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: <Widget>[
                                                  // RatingBar(
                                                  //   initialRating:
                                                  //       hotelData!.rating,
                                                  //   direction: Axis.horizontal,
                                                  //   allowHalfRating: true,
                                                  //   itemCount: 5,
                                                  //   itemSize: 24,
                                                  //   ratingWidget: RatingWidget(
                                                  //     full: Icon(
                                                  //       Icons.star_rate_rounded,
                                                  //       color: HotelAppTheme
                                                  //               .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //     half: Icon(
                                                  //       Icons.star_half_rounded,
                                                  //       color: HotelAppTheme
                                                  //               .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //     empty: Icon(
                                                  //       Icons
                                                  //           .star_border_rounded,
                                                  //       color: HotelAppTheme
                                                  //               .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //   ),
                                                  //   itemPadding:
                                                  //       EdgeInsets.zero,
                                                  //   onRatingUpdate: (rating) {
                                                  //     print(rating);
                                                  //   },
                                                  // ),

                                                  Text(
                                                    '${record!.courseInstructor}',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(top: 4),
                                            //   child: Row(
                                            //     children: <Widget>[
                                            //       TimeStudy(
                                            //           record!.timePeriod!),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '${record!.courseSemester}/${record!.courseYear}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          '${record!.courseCredit}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: (() {
                            if (record!.register == false) {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                  onTap: () {
                                    havetoday.addMR30(record!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.favorite_rounded,
                                      color: HotelAppTheme.buildLightTheme()
                                          .primaryColor,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.app_registration,
                                      color: Color.fromARGB(255, 255, 138, 83),
                                    ),
                                  ),
                                ),
                              );
                            }
                          })(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Text TimeStudy(String periodtime) {
    String strcheck = StringTimeStudy(periodtime.toString());
    return Text(
      strcheck,
      style: TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 189, 22, 22).withOpacity(0.8)),
    );
  }
}
