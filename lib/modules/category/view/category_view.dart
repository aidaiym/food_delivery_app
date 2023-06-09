import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../export_files.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(CategoryService()),
      child: const CategoryViewBody(),
    );
  }
}

class CategoryViewBody extends StatefulWidget {
  const CategoryViewBody({super.key});

  @override
  State<CategoryViewBody> createState() => _CategoryViewBodyState();
}

class _CategoryViewBodyState extends State<CategoryViewBody> {
  @override
  void initState() {
    context.read<CategoryCubit>().getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/icons/location.svg'),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Location of Phone',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                currentDate,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 18,
                    fontFamily: 'SF Pro Display'),
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: SizedBox(
              width: 44,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/user_avatar.png'),
                radius: 16,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          switch (state.status) {
            case FetchStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case FetchStatus.error:
              return const Center(
                child: Text('Error'),
              );
            case FetchStatus.success:
              return CategoryListWidget(state.categories ?? []);
          }
        },
      ),
    );
  }
}

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget(
    this.categories, {
    super.key,
  });
  final List<Category> categories;

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          Category category = widget.categories[index];
          return Padding(
            padding: const EdgeInsets.all(28.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DishListView(category: category),
                  ),
                );
              },
              child: Stack(
                children: [
                  Image.network(
                    category.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
