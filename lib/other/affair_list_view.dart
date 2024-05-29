import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/model/affair_list_data.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';

class AffairListView extends StatelessWidget {
  const AffairListView(
      {Key? key,
      this.affairData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final AffairListData? affairData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color.fromARGB(255, 67, 67, 67).withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              color: RuConnextAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, top: 4, bottom: 4),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 60,
                                                        height: 60,
                                                      )
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          0, 0, 0, 0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              '${affairData!.imagePath}'))),
                                                ),
                                                Expanded(
                                                  child: ListTile(
                                                    title: Text(
                                                        affairData!.titleTxt,
                                                        style: AppTheme.body1),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 1,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
}
