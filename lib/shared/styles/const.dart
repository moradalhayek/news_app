import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData themLight()=>ThemeData(
                primarySwatch: Colors.orange,
                  textTheme:  const TextTheme(bodyText1:TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.w600,
                  // color: Colors.black 
                  ) ),
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme:  const AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark),
                      titleSpacing: 20,
                      titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      actionsIconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      color: Colors.white,
                      elevation: 0,
                    ),
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                          unselectedItemColor: Colors.red,
                            type: BottomNavigationBarType.fixed,
                            ),
                             
                            );
ThemeData themDark()=>ThemeData(
                  applyElevationOverlayColor:false ,
                primarySwatch: Colors.orange,
                  // ignore: prefer_const_constructors
                  textTheme:   TextTheme(bodyText1:TextStyle(
                     color: Colors.white,
                   fontSize: 18,
                   fontWeight: FontWeight.w600,
                
                  ) ),
                  
                    scaffoldBackgroundColor: HexColor('333739'),
                    appBarTheme:  AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: HexColor('333739'),
                          statusBarIconBrightness: Brightness.light),
                      titleSpacing: 20,
                      titleTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      actionsIconTheme: const IconThemeData(
                        color: Colors.white,
                      ),
                      color: HexColor('333739'),
                      elevation: 0,
                    ),
                    bottomNavigationBarTheme:
                         BottomNavigationBarThemeData(
                          backgroundColor: HexColor('333739'),
                          unselectedItemColor: Colors.red,
                            type: BottomNavigationBarType.fixed));
               