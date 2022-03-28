import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/dashboard/views/customer_sujession.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class FindCustomerSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: AppColors.bgLight,
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            title: Text('Muhsin'),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: AppColors.bgLight,
      child: CustomerSearchView(
        searchTerm: query.toLowerCase(),
      ),
    );
  }
}
