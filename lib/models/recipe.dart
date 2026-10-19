class Recipe({
  required final String title,
  required final String imageUrl,
  required final String category,
  required final int minutes,
  required final int servings,
  required final List<String> ingredients,
  required final List<String> steps,
});

final arrabiata = Recipe(
  title: "Penne all'arrabiata",
  imageUrl: "https://i.blogs.es/19c40e/penne/1366_2000.jpg",
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
);
