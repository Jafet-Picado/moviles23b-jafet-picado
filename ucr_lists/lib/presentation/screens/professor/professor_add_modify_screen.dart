import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ucr_lists/presentation/widgets.dart';

class ProfessorAddModifyScreen extends StatelessWidget {
  const ProfessorAddModifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar profesor'),
      ),
      body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              _ProfessorFormView()
            ],
          )),
    );
  }
}

class _ProfessorFormView extends StatefulWidget {
  const _ProfessorFormView();

  @override
  State<_ProfessorFormView> createState() => _ProfessorFormViewState();
}

class _ProfessorFormViewState extends State<_ProfessorFormView> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    if (value == null) {
      return 'No puede ser vacío';
    }
    if (value.trim().isEmpty) {
      return 'No puede ser vacío';
    }
    if (value.trim().length < 3) {
      return 'Debe tener más de 3 carácteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _keyForm,
        child: Column(
          children: [
            CustomTextFormField(
              controller: _firstNameController,
              label: 'Nombre',
              hintText: 'Agregue el nombre',
              icon: Icons.person,
              validator: _validate,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-Za-zÀ-ÖØ-öø-ÿ]')),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              controller: _lastNameController,
              label: 'Apellido',
              hintText: 'Agregue el apellido',
              icon: Icons.person,
              validator: _validate,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-Za-zÀ-ÖØ-öø-ÿ]')),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {
                    bool isValid = _keyForm.currentState!.validate();
                    if (isValid) {
                      print(
                          '${_firstNameController.text} ${_lastNameController.text}');
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Guardar'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
