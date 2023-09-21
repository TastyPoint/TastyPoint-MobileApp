import 'package:flutter/material.dart';
import 'package:tasty/api/Service.dart';
import 'package:tasty/api/Promotion.dart';

class CreatePromotionPage extends StatefulWidget {
  final int userId;

  const CreatePromotionPage({Key? key, required this.userId}) : super(key: key);

  @override
  _CreatePromotionPageState createState() => _CreatePromotionPageState();
}

class _CreatePromotionPageState extends State<CreatePromotionPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _subtitleController = TextEditingController();
    _descriptionController = TextEditingController();
    _imageController = TextEditingController();
    _quantityController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _createPromotion() async {
    if (_formKey.currentState!.validate()) {
      final promotion = Promotion(
        id: 5,
        title: _titleController.text,
        subtitle: _subtitleController.text,
        description: _descriptionController.text,
        image: _imageController.text,
        quantity: int.parse(_quantityController.text),
        userProfileId: widget.userId,
      );

      try {
        List<Promotion> promotions = await service.getPromotions();
        int maxId = promotions.fold(0, (maxId, promotion) => promotion.id > maxId ? promotion.id : maxId);
        int newId = maxId + 1;
        promotion.id = newId;

        final createdPromotion = await service.createPromotion(promotion);

        // Muestra el mensaje "Promoción creada" en un Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Promoción creada'),
          ),
        );

        // Realiza alguna acción con la nueva promoción creada

        // Vuelve a la página anterior después de publicar la promoción
        Navigator.pop(context);
      } catch (e) {
        // Maneja el error en caso de que la creación falle
        print('Error creating promotion: $e');
        // Muestra un mensaje de error en un Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Promoción creada'),
          ),
        );
      }
    }
  }




  void _showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Mensaje'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFBC3D),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFBC3D),
        elevation: 0,
        title: Text(
          "Create Promotion",
          style: TextStyle(
            color: Color(0xFF3a3737),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _subtitleController,
                        decoration: InputDecoration(labelText: 'Price'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a price';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _imageController,
                        decoration: InputDecoration(labelText: 'ImageUrl'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an image URL';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(labelText: 'Quantity'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the quantity';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _createPromotion();
                        },
                        child: Text('Create Promotion'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFFDFBEF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
