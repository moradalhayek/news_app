import 'package:flutter/material.dart';

Widget buildItembulder(context,article,index)=>Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                 image: DecorationImage(
                      image: NetworkImage(
                          '${article['urlToImage']}',
                      
                    ),
                    fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(
                width:10,
              ),
              Expanded(
                child: Container(
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text('${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            ),
                      ),
                      Text(
                        '${article['publishedAt']}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),

        );
        Widget myDrive()=>Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20
          ),
          child: Container(
            height: 1,
            width: 1,
            color: Colors.grey[300],
          ),
        );
Widget deffaultFormField({
  required TextEditingController controller,
  TextInputType? type,
  
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
      
      onTap: onTap,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
      
      ),
    );
    Widget articleBulider(List list, context, {isSearch = false}) => isSearch
    ? Container()
    : list.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext BuildContext, index) =>
                buildItembulder(list[index], context, index),
            separatorBuilder: (BuildContext BuildContext, index) => myDrive(),
            itemCount: list.length,
          );