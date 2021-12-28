//
//  HomeModel.swift
//  Soulmate
//
//  Created by dasha on 29.12.2021.
//

import Foundation


struct HomeModel: Decodable {
    var users: [UserModel]
    var cards: [CardModel]?
    var folder: [FolderModel]
}


/*
 {
     "users": [
         {
             "path": null,
             "id": 4,
             "username": "kasigina",
             "firstName": "Мария",
             "lastName": "Касыгина",
             "age": 27,
             "city": "Лос-Анджелес",
             "color": "#AAADEC",
             "description": "Живу творчеством. Главный дизайнер LinkedIn. Cоздаю нетривиальные и продающие дизайны сайтов и приложений, как фрилансер. Паралельно веду блог о дизайне на YouTube - @kasdes ",
             "views": 213,
             "avatars": [
                 {
                     "link": "http://localhost:8080/img/kasigina.png",
                     "main": true
                 }
             ]
         },
         {
             "path": null,
             "id": 2,
             "username": "novembrz",
             "firstName": "Даша",
             "lastName": "Курилова",
             "age": 22,
             "city": "Москва",
             "color": "#56799A",
             "description": "I am programmer but not only..",
             "views": 200,
             "avatars": [
                 {
                     "link": "http://localhost:8080/img/kurilova.jpg",
                     "main": true
                 }
             ]
         },
         {
             "path": null,
             "id": 3,
             "username": "ignatenko",
             "firstName": "Ника",
             "lastName": "Игнатенко",
             "age": 22,
             "city": "Москва",
             "color": "#C9AA92",
             "description": "Спроектирую не только здания, но и твои брови",
             "views": 5,
             "avatars": [
                 {
                     "link": "http://localhost:8080/img/ignatenko.jpg",
                     "main": true
                 }
             ]
         },
         {
             "path": null,
             "id": 1,
             "username": "yar",
             "firstName": "Ярослав",
             "lastName": "Девятовский",
             "age": 22,
             "city": "Илькино",
             "color": "#903F3C",
             "description": "I am programmer",
             "views": 3,
             "avatars": [
                 {
                     "link": "http://localhost:8080/img/yar.jpg",
                     "main": true
                 }
             ]
         }
     ],
     "cards": [],
     "folders": [
         {
             "previewPictures": [],
             "name": "My Juniour Works",
             "author": {
                 "path": null,
                 "id": 1,
                 "username": "yar",
                 "firstName": "Ярослав",
                 "lastName": "Девятовский",
                 "age": 22,
                 "city": "Илькино",
                 "color": "#903F3C",
                 "description": "I am programmer",
                 "views": 3,
                 "avatars": [
                     {}
                 ]
             }
         },
         {
             "previewPictures": [],
             "name": "My first Portraits",
             "author": {
                 "path": null,
                 "id": 2,
                 "username": "novembrz",
                 "firstName": "Даша",
                 "lastName": "Курилова",
                 "age": 22,
                 "city": "Москва",
                 "color": "#56799A",
                 "description": "I am programmer but not only..",
                 "views": 200,
                 "avatars": [
                     {}
                 ]
             }
         }
     ]
 }
 */
