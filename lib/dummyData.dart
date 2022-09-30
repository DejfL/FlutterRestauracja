import 'package:flutter/foundation.dart';
import 'package:restauracja/models/modification.dart';
import 'package:restauracja/models/product.dart';
import 'package:restauracja/models/topping.dart';
import 'models/category.dart' as category;

List<category.Category> categories = [
  category.Category(1, 'Wszystko', isActive: true),
  category.Category(2, 'Pizza'),
  category.Category(3, 'Dania główne'),
  category.Category(4, 'Zupy'),
  category.Category(5, 'Napoje'),
];

const List<Topping> pizzaTopings = [
  Topping(name: 'Podwójny ser', price: 2.5),
  Topping(name: 'Salami', price: 2.5),
  Topping(name: 'Szynka', price: 2.5),
  Topping(name: 'Pieczarki', price: 2.5),
  Topping(name: 'Kurczak', price: 2.5),
];

const List<Modification> pizzaModifications = [
  Modification(name: 'Bezglutenowe', price: 4),
  Modification(name: 'Serowe brzegi', price: 6),
];

List<Product> products = [
  Product(
    name: 'Margherita',
    price: 25,
    imageSrc:
        'https://www.kwestiasmaku.com/sites/v123.kwestiasmaku.com/files/pizza_margherita01.jpg',
    category: category.Category(2, 'Pizza'),
    topings: pizzaTopings,
    modifications: pizzaModifications,
  ),
  Product(
    name: 'Vegetariana',
    price: 27,
    imageSrc:
        'https://staticsmaker.iplsc.com/smaker_prod_2017_08_14/4fba3f26b05b98dd7ef78a84e1c8d4e2-recipe_main.jpg',
    category: category.Category(2, 'Pizza'),
    topings: pizzaTopings,
    modifications: pizzaModifications,
  ),
  Product(
    name: 'Tosca',
    price: 30,
    imageSrc:
        'https://media-cdn.tripadvisor.com/media/photo-s/10/99/9a/f3/tosca-pizza-tomato-buffalo.jpg',
    category: category.Category(2, 'Pizza'),
    topings: pizzaTopings,
    modifications: pizzaModifications,
  ),
  Product(
    name: 'Venezia',
    price: 31,
    imageSrc:
        'https://i1.nocimg.pl/d6/895/188--winouj-cie-restauracja-pizzeria-venezia.jpg',
    category: category.Category(2, 'Pizza'),
    topings: pizzaTopings,
    modifications: pizzaModifications,
  ),

  ///dania głowne

  Product(
    name: 'Schabowy z (do wyboru jedno z) frytkami/ryżem/ziemniakami',
    price: 35,
    imageSrc:
        'https://staticsmaker.iplsc.com/smaker_prod_2019_03_09/fa3c2e12df66513037181b9a3e32181a-lg.jpg',
    category: category.Category(3, 'Dania główne'),
  ),
  Product(
    name: 'Ryba z frytkami',
    price: 25,
    imageSrc:
        'https://i.wpimg.pl/1200x/filerepo.grupawp.pl/api/v1/display/embed/42e7e77a-adaa-4904-9e61-94a27daa63a0',
    category: category.Category(3, 'Dania główne'),
  ),
  Product(
    name: 'Placek po węgiersku',
    price: 25,
    imageSrc:
        'https://i.wpimg.pl/1200x/filerepo.grupawp.pl/api/v1/display/embed/42e7e77a-adaa-4904-9e61-94a27daa63a0',
    category: category.Category(3, 'Dania główne'),
  ),

  //zupy

  Product(
    name: 'Pomidorowa',
    price: 13.5,
    imageSrc:
        'https://cdn.aniagotuje.com/pictures/articles/2018/06/74982-v-900x556.jpg',
    category: category.Category(4, 'Zupy'),
  ),
  Product(
    name: 'Rosół',
    price: 12,
    imageSrc:
        'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/rosol_z_kury170242.jpg',
    category: category.Category(4, 'Zupy'),
  ),

  //napoje całe te

  Product(
    name: 'Kawa',
    price: 7,
    imageSrc:
        'https://i.wpimg.pl/1200x/filerepo.grupawp.pl/api/v1/display/embed/01642992-84b7-451e-a725-06881e9e9970',
    category: category.Category(5, 'Napoje'),
  ),
  Product(
    name: 'Herbata',
    price: 7,
    imageSrc:
        'https://wszystkoojedzeniu.pl/site/assets/files/3184/herbata.650x0.jpg',
    category: category.Category(5, 'Napoje'),
  ),
  Product(
    name: 'Cola',
    price: 7,
    imageSrc: 'https://strefainwestorow.pl/sites/default/files/coca%20cola.jpg',
    category: category.Category(5, 'Napoje'),
  ),
];
