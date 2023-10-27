import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:ucr_lists/domain/schemas.dart';
import 'package:ucr_lists/presentation/blocs.dart';
import 'package:ucr_lists/presentation/widgets.dart';

class StudentAddModifyScreen extends StatelessWidget {
  final int? id;

  const StudentAddModifyScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StudentCubit()),
        BlocProvider(create: (context) => CourseCubit()),
      ],
      child: _StudentAddModifyScreen(id: id),
    );
  }
}

class _StudentAddModifyScreen extends StatefulWidget {
  final int? id;
  const _StudentAddModifyScreen({this.id});

  @override
  State<_StudentAddModifyScreen> createState() =>
      _StudentAddModifyScreenState();
}

class _StudentAddModifyScreenState extends State<_StudentAddModifyScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      context.read<StudentCubit>().getStudent(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstName = context.watch<StudentCubit>().state.firstName;
    final lastName = context.watch<StudentCubit>().state.lastName;

    return Scaffold(
      appBar: AppBar(
        title: (widget.id == null)
            ? const Text('Agregar estudiante')
            : Text('$firstName $lastName'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            _StudentFormView(
              id: widget.id,
            ),
          ],
        ),
      ),
    );
  }
}

class _StudentFormView extends StatefulWidget {
  final int? id;

  const _StudentFormView({
    this.id,
  });

  @override
  State<_StudentFormView> createState() => _StudentFormViewState();
}

class _StudentFormViewState extends State<_StudentFormView> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _carnetController = TextEditingController();
  final _emailController = TextEditingController();

  List<int> coursesSelected = [];

  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().getCourses();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _carnetController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _carnetController.clear();
    _emailController.clear();
  }

  String? _validateName(String? value) {
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

  String? _validateCarnet(String? value) {
    if (value == null) {
      return 'No puede ser vacío';
    }
    if (value.trim().isEmpty) {
      return 'No puede ser vacío';
    }
    if (value.trim().length != 6) {
      return 'Debe tener 6 carácteres';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null) {
      return 'No puede ser vacío';
    }
    if (value.trim().isEmpty) {
      return 'No puede ser vacío';
    }
    if (value.trim().length <= 6) {
      return 'Debe tener 6 o más carácteres';
    }
    if (value.trim().length > 256) {
      return 'No debe tener más de 256 carácteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final List<Course> courses = context.watch<CourseCubit>().state.courses;

    final List<MultiSelectItem<int>> coursesEntries = [];

    for (int index = 0; index < courses.length; index++) {
      coursesEntries.add(MultiSelectItem(
          index, '${courses[index].code} ${courses[index].name}'));
    }

    final studentCubit = context.watch<StudentCubit>();
    if (widget.id != null) {
      _firstNameController.text = context.read<StudentCubit>().state.firstName;
      _lastNameController.text = context.read<StudentCubit>().state.lastName;
      _carnetController.text = context.read<StudentCubit>().state.carnet;
      _emailController.text = context.read<StudentCubit>().state.email;
      List<int> temp = [];
      for (Course course
          in context.read<StudentCubit>().state.courses.toList()) {
        temp.add(
            courses.indexWhere((otherCourse) => otherCourse.id == course.id));
      }
      setState(() {
        coursesSelected = temp;
      });
    }

    return Form(
      key: _keyForm,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _firstNameController,
            label: 'Nombre',
            hintText: 'Agregue el nombre',
            icon: Icons.person,
            validator: _validateName,
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
            validator: _validateName,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[A-Za-zÀ-ÖØ-öø-ÿ]')),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            controller: _carnetController,
            label: 'Carnet',
            hintText: 'Agregue el carnet',
            icon: Icons.account_box_rounded,
            validator: _validateCarnet,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]')),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            controller: _emailController,
            label: 'Correo electrónico',
            hintText: 'Agregue el correo',
            icon: Icons.email_rounded,
            validator: _validateEmail,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9@._-]')),
            ],
          ),
          const SizedBox(height: 15),
          MultiSelectDialogField<int>(
            items: coursesEntries,
            initialValue: coursesSelected,
            title: const Text('Cursos'),
            selectedColor: colors.primaryContainer,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                color: colors.secondaryContainer,
              ),
            ),
            buttonIcon: const Icon(
              Icons.arrow_downward_rounded,
            ),
            buttonText: const Text(
              'Seleccione los cursos',
              style: TextStyle(
                fontSize: 16,
                overflow: TextOverflow.fade,
              ),
            ),
            onConfirm: (results) {
              coursesSelected = results;
            },
            itemsTextStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            selectedItemsTextStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            checkColor: Colors.white,
            confirmText: const Text('Guardar'),
            cancelText: const Text('Cancelar'),
            unselectedColor: Colors.white,
            chipDisplay: MultiSelectChipDisplay(
              items: coursesEntries,
              chipColor: colors.primaryContainer,
              textStyle: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  bool isValid = _keyForm.currentState!.validate();
                  if (isValid) {
                    List<Course> newCourses = [];
                    for (int index in coursesSelected) {
                      newCourses.add(courses[index]);
                    }
                    Student student = Student()
                      ..firstName = _firstNameController.text
                      ..lastName = _lastNameController.text
                      ..carnet = _carnetController.text
                      ..email = _emailController.text
                      ..courses.addAll(newCourses);
                    if (widget.id != null) student.id = widget.id;
                    studentCubit.addStudent(student);
                    _clearForm();
                    context.pop();
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.save),
                      const SizedBox(
                        width: 10,
                      ),
                      Text((widget.id == null) ? 'Guardar' : 'Modificar'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
