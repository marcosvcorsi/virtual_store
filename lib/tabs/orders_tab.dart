import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/login_screen.dart';
import 'package:virtual_store/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      String uid = UserModel
          .of(context)
          .firebaseUser
          .uid;

      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("users").document(uid).collection(
            "orders").getDocuments(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList(),
          );
        },
      );
    } else {
      return Container(
        padding: EdgeInsets.all((16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.list,
              color: Theme
                  .of(context)
                  .primaryColor,
              size: 80.0,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Faça o login para acompanhar!",
              style:
              TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text(
                "Entrar",
                style: TextStyle(fontSize: 18.0),
              ),
              textColor: Colors.white,
              color: Theme
                  .of(context)
                  .primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      );
    }
  }
}
