import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:client_mohamoon/app/models/lawyer_model.dart';
import 'package:client_mohamoon/app/service/lawyer_service.dart';
import 'package:get/get.dart';

class SearchLawyerDelegat extends SearchDelegate<Lawyer> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.remove_circle_outline_outlined),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Lawyer());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<List<Lawyer>>(
      future: LawyerService().searchLawyer(query),
      builder: (contex, snapshot) {
        // if (query.isEmpty) return buildNoSuggestions();
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Text(
                  'Something went wrong!',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              );
            } else {
              return buildResultSuccess(snapshot.data!);
            }
        }
      });

  @override
  Widget buildSuggestions(BuildContext context) => FutureBuilder<List<Lawyer>>(
        future: LawyerService().searchLawyer(query),
        builder: (context, snapshot) {
          //  if (query.isEmpty) return buildNoSuggestions();
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError || snapshot.data!.isEmpty) {
                return buildNoSuggestions();
              } else {
                return buildSuggestionsSuccess(snapshot.data!);
              }
          }
        },
      );

  Widget buildSuggestionsSuccess(List<Lawyer> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF00000),
                    blurRadius: 40,
                  ),
                ]),
            child: ListTile(
              onTap: () {
                query = suggestion.lawyerName!;
                showResults(context);
              },
              leading: Icon(Icons.person),
              // title: Text(suggestion),
              title: Text(suggestion.lawyerName!,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  )),
            ),
          );
        },
      );

  Widget buildNoSuggestions() => Center(
        child: Text(
          'No suggestions!',
          style: TextStyle(fontSize: 28, color: Colors.black45),
        ),
      );

  Widget buildResultSuccess(List<Lawyer> lawyer) => ListView.builder(
      itemCount: lawyer.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00000),
                  blurRadius: 40,
                ),
              ]),
          child: ListTile(
            onTap: () {
              Get.toNamed('/detail-lawyer',
                  arguments: lawyer[index]);
            },
            leading: CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(lawyer[index].lawyerPicture!),
            ),
            title: Text(lawyer[index].lawyerName!),
          ),
        );
      });
}
