🎓 Comprendre BlocProvider, BlocBuilder, BlocListener et BlocConsumer

🧱 BlocProvider

BlocProvider(
create: (context) => CarBloc(apiCarRepo),
child: MyApp(),
)

✅ À quoi ça sert ?
•	Fournit une instance de Bloc ou Cubit à tous les widgets descendants dans l’arbre.
•	Permet d’accéder au bloc via context.read<T>() ou context.watch<T>().

❗ Ne pas faire

Recréer le bloc à chaque build. Ça réinitialise l’état et casse la logique.

⸻

🧪 BlocBuilder

BlocBuilder<CarBloc, CarState>(
builder: (context, state) {
if (state is GetCarSuccess) {
return Text("Car VIN: ${state.car.vin}");
}
return CircularProgressIndicator();
},
)

✅ À quoi ça sert ?
•	Reconstruit l’UI en fonction des changements de state.

⚠️ Important

N’exécute pas d’effet secondaire ici (ex: navigation, snackbar). Juste du pur UI.

⸻

🔔 BlocListener

BlocListener<CarBloc, CarState>(
listenWhen: (previous, current) => current is GetCarFailure,
listener: (context, state) {
if (state is GetCarFailure) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Erreur de chargement !')),
);
}
},
child: YourWidget(),
)

✅ À quoi ça sert ?
•	Écoute les changements de state pour exécuter un effet secondaire (navigation, toast, logs…).
•	Ne reconstruit pas l’UI.

⸻

♻️ BlocConsumer

BlocConsumer<CarBloc, CarState>(
listener: (context, state) {
if (state is GetCarFailure) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text("Erreur réseau")),
);
}
},
builder: (context, state) {
if (state is GetCarSuccess) {
return Text("Voiture : ${state.car.vin}");
}
return CircularProgressIndicator();
},
)

✅ À quoi ça sert ?
•	Combine BlocBuilder + BlocListener.
•	Idéal quand tu veux à la fois réagir à un changement d’état et reconstruire l’UI.

⸻

🧠 Résumé : quand utiliser quoi ?

Besoin	Utiliser
Fournir un bloc à un sous-arbre	BlocProvider
Reconstruire le widget à chaque state	BlocBuilder
Réagir à un state sans rebuild UI	BlocListener
Faire les deux (rebuild + effets secondaires)	BlocConsumer


⸻

💡 Exemple complet combiné

BlocProvider(
create: (_) => CarBloc(apiCarRepo)..add(GetCar()),
child: BlocConsumer<CarBloc, CarState>(
listener: (context, state) {
if (state is GetCarFailure) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text("Erreur lors de la récupération des données")),
);
}
},
builder: (context, state) {
if (state is GetCarSuccess) {
return HomePage(car: state.car);
} else if (state is GetCarLoading) {
return Center(child: CircularProgressIndicator());
} else {
return Center(child: Text("Erreur inattendue"));
}
},
),
)

