import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';

class MR30Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: Consumer<MR30Provider>(
        builder: (context, dataProvider, _) {
          if (dataProvider.listmr30.courseSemester == "") {
            // Fetch initial data from provider
            dataProvider.fetchData();
            return Center(child: CircularProgressIndicator());
          } else {
            return RefreshIndicator(
              onRefresh: dataProvider.fetchData,
              child: ListView.builder(
                itemCount: dataProvider.listmr30.rECORD!.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == dataProvider.listmr30.rECORD!.length - 1) {
                    // Load more data when reaching the end of the list
                    dataProvider.loadMoreData();
                  }
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(dataProvider.listmr30.rECORD![index].courseNo!),
                        Text(dataProvider.listmr30.rECORD![index].courseYear!),
                        Text(dataProvider
                            .listmr30.rECORD![index].courseSemester!),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
