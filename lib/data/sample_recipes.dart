import 'package:receptari/models/recipe.dart';

final sampleRecipes = [
  Recipe(
    title: "Penne all'arrabbiata",
    imageUrl: 'https://i.blogs.es/19c40e/penne/1366_2000.jpg',
    category: 'Vegetariana',
    minutes: 30,
    servings: 4,
    ingredients: [
      '450 g de macarrons',
      "60 ml d'oli d'oliva",
      "3 grans d'all",
      '1 llauna de tomàquet triturat',
      '½ culleradeta de bitxo sec',
      "½ culleradeta d'herbes italianes",
      "6 fulles d'alfàbrega",
      'Parmesà ratllat',
    ],
    steps: [
      'Bull els macarrons en aigua amb sal fins que siguin al dente.',
      "Escalfa l'oli en una paella i sofregeix-hi l'all tallat a làmines.",
      'Afegeix el tomàquet, el bitxo i les herbes, i deixa-ho coure 10 minuts.',
      'Barreja la salsa amb els macarrons escorreguts.',
      "Serveix-ho amb l'alfàbrega i el parmesà per sobre.",
    ],
  ),
  Recipe(
    title: 'Espaguetis a la carbonara',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/llcbn01574260722.jpg',
    category: 'Pasta',
    minutes: 25,
    servings: 4,
    ingredients: [
      "400 g d'espaguetis",
      '150 g de cansalada',
      "4 rovells d'ou",
      '80 g de formatge pecorino ratllat',
      'Pebre negre',
    ],
    steps: [
      'Bull els espaguetis en aigua amb sal.',
      'Daura la cansalada tallada a daus en una paella sense oli.',
      'Barreja els rovells amb el formatge i força pebre.',
      "Fora del foc, barreja la pasta amb la cansalada i la barreja d'ou.",
    ],
  ),
  Recipe(
    title: 'Truita de patates',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/quuxsx1511476154.jpg',
    category: 'Vegetariana',
    minutes: 40,
    servings: 4,
    ingredients: ['4 patates', '1 ceba', '6 ous', "Oli d'oliva", 'Sal'],
    steps: [
      'Pela les patates i la ceba i talla-les a làmines fines.',
      'Fregeix-les a foc lent amb força oli fins que siguin toves.',
      'Escorre-les i barreja-les amb els ous batuts i una mica de sal.',
      'Quall la truita a la paella per les dues bandes.',
    ],
  ),
  Recipe(
    title: 'Paella de marisc',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/9bl20p1763248192.jpg',
    category: 'Marisc',
    minutes: 60,
    servings: 4,
    ingredients: [
      "400 g d'arròs",
      '300 g de gambes',
      '500 g de musclos',
      '1 pebrot vermell',
      '2 tomàquets ratllats',
      '1 l de brou de peix',
      'Safrà',
    ],
    steps: [
      'Sofregeix el pebrot i el tomàquet a la paella.',
      "Afegeix l'arròs i remena'l un minut.",
      'Tira-hi el brou calent amb el safrà i deixa-ho coure 18 minuts sense remenar.',
      'Els últims minuts, posa-hi les gambes i els musclos per sobre.',
      'Deixa-la reposar 5 minuts abans de servir-la.',
    ],
  ),
  Recipe(
    title: 'Pancakes',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/rwuyqx1511383174.jpg',
    category: 'Postres',
    minutes: 20,
    servings: 4,
    ingredients: [
      '200 g de farina',
      '1 culleradeta de llevat',
      '2 ous',
      '300 ml de llet',
      '2 cullerades de sucre',
      'Mantega',
    ],
    steps: [
      'Bat la farina, el llevat, els ous, la llet i el sucre fins que no quedin grumolls.',
      'Unta una paella amb mantega i posa-hi un cullerot de massa.',
      'Quan surtin bombolles, gira el pancake i cou-lo un minut més.',
      'Serveix-los amb fruita, xarop o xocolata.',
    ],
  ),
  Recipe(
    title: 'Shakshuka',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/g373701551450225.jpg',
    category: 'Vegetariana',
    minutes: 30,
    servings: 2,
    ingredients: [
      '4 ous',
      '1 llauna de tomàquet triturat',
      '1 ceba',
      '1 pebrot vermell',
      '1 culleradeta de comí',
      'Julivert',
    ],
    steps: [
      'Sofregeix la ceba i el pebrot tallats.',
      'Afegeix el tomàquet i el comí, i deixa-ho coure 10 minuts.',
      'Fes quatre forats a la salsa i trenca-hi un ou a cada un.',
      'Tapa-ho i cou-ho fins que la clara quedi quallada.',
    ],
  ),
];
