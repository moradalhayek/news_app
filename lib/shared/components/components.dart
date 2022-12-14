import 'package:flutter/material.dart';
import 'package:news_app/shared/cubit/cubit.dart';

import '../../modules/web_view_screen/web_view_screen.dart';

Widget deffaultFormField({
  required TextEditingController controller,
  TextInputType? type,
  bool isPassword = false,
  VoidCallback? onTap,
  final FormFieldValidator<String>? validator,
  void Function(String)? onChanged,
  required String labelText,
  required IconData? prefixIcon,
  IconData? suffixIcon,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onTap: onTap,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: Icon(suffixIcon),
      ),
    );

Widget bulidArticleItem(article, context, index) => Container(
      color: NewsCubit.get(context).selectbusinessItem == index &&
              NewsCubit.get(context).isDesktop
          ? Colors.grey[300]
          : null,
      child: InkWell(
        onTap: () {
          NewsCubit.get(context).selectBusinessItem(index);
          navigateTo(context, WebViewScreen(url: article['url']));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                          "${ article['urlToImage']}"),
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "${article['title']}",
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 3,),
                      Text(
                        "${article['publishedAt']}",
                        style:Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey
                        )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

// ignore: avoid_types_as_parameter_names, non_constant_identifier_names
void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 15
  ),
  child:   Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey,
      ),
);

Widget articleBulider(List list, context, {isSearch = false}) => isSearch
    ? Container()
    : list.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                bulidArticleItem(list[index], context, index),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: list.length,
          );
