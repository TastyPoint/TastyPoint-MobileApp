import 'package:flutter/material.dart';
import 'package:tasty/api/Service.dart';
import 'package:tasty/api/Promotion.dart';

class EditPromotionPage extends StatefulWidget {
  final Promotion promotion;

  const EditPromotionPage({Key? key, required this.promotion}) : super(key: key);

  @override
  _EditPromotionPageState createState() => _EditPromotionPageState();
}

class _EditPromotionPageState extends State<EditPromotionPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.promotion.title);
    _subtitleController = TextEditingController(text: widget.promotion.subtitle);
    _descriptionController = TextEditingController(text: widget.promotion.description);
    _imageController = TextEditingController(text: widget.promotion.image);
    _quantityController = TextEditingController(text: widget.promotion.quantity.toString());
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

  Future<void> _editPromotion() async {
    if (_formKey.currentState!.validate()) {
      final editedPromotion = Promotion(
        id: widget.promotion.id,
        title: _titleController.text,
        subtitle: _subtitleController.text,
        description: _descriptionController.text,
        image: _imageController.text,
        quantity: int.parse(_quantityController.text),
        userProfileId: widget.promotion.userProfileId,
      );

      try {
        await service.editPromotion(editedPromotion);

        // Muestra el mensaje "Promoción editada" en un Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Promoción editada'),
          ),
        );

        // Realiza alguna acción con la promoción editada

        // Vuelve a la página anterior después de editar la promoción
        Navigator.pop(context);
      } catch (e) {
        // Maneja el error en caso de que la edición falle
        print('Error editing promotion: $e');
        // Muestra un mensaje de error en un Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error editing promotion'),
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
          "Edit Promotion",
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
                        onPressed: _editPromotion,
                        child: Text('Edit Promotion'),
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
