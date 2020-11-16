import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../dummy_data.dart';

//import '../../providers/companies_list.dart';

class DataSearch extends SearchDelegate<String> {
  final companies = DummyData.DUMMY_COMPANIES;
  QuerySnapshot searchList;
  bool isEmployer;

  DataSearch(this.searchList, this.isEmployer);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          print(isEmployer);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = searchList != null ? searchList.documents : null;
    final filteredSuggestionList = suggestionList != null
        ? suggestionList
            .where(
              (element) =>
                  element.data[isEmployer ? 'name' : 'company_name']
                      .toLowerCase()
                      .startsWith(
                        query.toLowerCase(),
                      ) ||
                  element.data[isEmployer ? 'course' : 'industry']
                      .toLowerCase()
                      .startsWith(
                        query.toLowerCase(),
                      ) ||
                  element.data[isEmployer ? 'faculty' : 'industry']
                      .toLowerCase()
                      .startsWith(
                        query.toLowerCase(),
                      ),
            )
            .toList()
        : null;

    return searchList != null
        ? ListView.builder(
            itemCount: filteredSuggestionList.length,
            itemBuilder: (ctx, i) => ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: filteredSuggestionList[i]
                            .data[isEmployer ? 'profile_image' : 'logo'] !=
                        null
                    ? NetworkImage(
                        filteredSuggestionList[i]
                            .data[isEmployer ? 'profile_image' : 'logo'],
                      )
                    : null,
              ),
              title: Text(filteredSuggestionList[i]
                  .data[isEmployer ? 'name' : 'company_name']),
            ),
          )
        : ListView(
            children: [],
          );
  }
}
