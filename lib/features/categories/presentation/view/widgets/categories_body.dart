import 'package:elevate_flower_app/core/shared/widgets/filter_bottom_sheet.dart';
import 'package:elevate_flower_app/features/categories/presentation/view/widgets/category_tab_builder.dart';
import 'package:elevate_flower_app/features/categories/presentation/view/widgets/filter_bottom.dart';
import 'package:elevate_flower_app/features/categories/presentation/view/widgets/product_card_builder.dart';
import 'package:elevate_flower_app/features/categories/presentation/view/widgets/search_bar_with_filtter.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_events.dart';
import 'package:elevate_flower_app/features/filter/presentation/view/widgets/filter_card_builder.dart';
import 'package:elevate_flower_app/features/filter/presentation/view_model/cubit/filter_cubit.dart';
import 'package:elevate_flower_app/features/filter/presentation/view_model/cubit/filter_states.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBody extends StatefulWidget {
  const CategoriesBody({super.key, this.incomingIndex});
  final int? incomingIndex;

  @override
  State<CategoriesBody> createState() => _CategoriesBodyState();
}

class _CategoriesBodyState extends State<CategoriesBody> {
  SortOption? selectedSort;

  void _showFilterSheet() {
    showFilterBottomSheet(
      context: context,
      selectedSort: selectedSort,
      onApplyFilter: (sort) {
        setState(() {
          selectedSort = sort;
        });

        // ✅ تطبيق الفلتر باستخدام Cubit
        if (sort != null) {
          context.read<FilterCubit>().applyFilter(sort.toFilterType());
        } else {
          // إذا تم إزالة الفلتر، أعد تحميل البيانات الأصلية
          context.read<FilterCubit>().clearFilter();
          context.read<CategoriesCubit>().onEvent(GetAllDataEvent());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesCubit, CategoriesStates>(
      listenWhen: (previous, current) {
        // Listen to changes in products state (which happens when category changes)
        return previous.productsOfCategory != current.productsOfCategory;
      },
      listener: (context, state) {
        // If products are loading (category changed), clear the filter
        state.productsOfCategory.when(
          initial: () {},
          loading: () {
            if (selectedSort != null) {
              setState(() {
                selectedSort = null;
              });
              context.read<FilterCubit>().loadProducts(); // Or clearFilter()
            }
          },
          success: (_) {},
          error: (_) {},
        );
      },
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SearchBarWithFiltter(onFilterTap: _showFilterSheet),
                CategoryTabBuilder(incomingIndex: widget.incomingIndex),
                const SizedBox(height: 10),

                // ✅ نعرض المنتجات بناءً على حالة الفلتر
                Expanded(
                  child: BlocBuilder<FilterCubit, FilterState>(
                    builder: (context, filterState) {
                      // إذا كان هناك فلتر نشط
                      if (filterState is FilterLoaded &&
                          filterState.appliedFilter != null) {
                        // ✅ اعرض المنتجات المفلترة باستخدام FilterCardBuilder
                        return const FilterCardBuilder();
                      }

                      // ✅ إذا لم يكن هناك فلتر، اعرض المنتجات العادية
                      return const ProductCardBuilder();
                    },
                  ),
                ),
              ],
            ),
            FilterBottom(selectedSort: selectedSort, onTap: _showFilterSheet),
          ],
        ),
      ),
    );
  }
}




// import 'package:elevate_flower_app/core/shared/widgets/filter_bottom_sheet.dart';
// import 'package:elevate_flower_app/features/categories/presentation/view/widgets/category_tab_builder.dart';
// import 'package:elevate_flower_app/features/categories/presentation/view/widgets/filter_bottom.dart';
// import 'package:elevate_flower_app/features/categories/presentation/view/widgets/product_card_builder.dart';
// import 'package:elevate_flower_app/features/categories/presentation/view/widgets/search_bar_with_filtter.dart';
// import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
// import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_events.dart';
// import 'package:elevate_flower_app/features/filter/presentation/view_model/cubit/filter_cubit.dart';
// import 'package:elevate_flower_app/features/filter/presentation/view_model/cubit/filter_states.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CategoriesBody extends StatefulWidget {
//   const CategoriesBody({super.key, this.incomingIndex});
//   final int? incomingIndex;

//   @override
//   State<CategoriesBody> createState() => _CategoriesBodyState();
// }

// class _CategoriesBodyState extends State<CategoriesBody> {
//   SortOption? selectedSort;

//   void _showFilterSheet() {
//     showFilterBottomSheet(
//       context: context,
//       selectedSort: selectedSort,
//       onApplyFilter: (sort) {
//         setState(() {
//           selectedSort = sort;
//         });

//         // ✅ تطبيق الفلتر باستخدام Cubit
//         if (sort != null) {
//           context.read<FilterCubit>().applyFilter(sort.toFilterType());
//         } else {
//           // إذا تم إزالة الفلتر، أعد تحميل البيانات الأصلية
//           context.read<FilterCubit>().clearFilter();
//           context.read<CategoriesCubit>().onEvent(GetAllDataEvent());
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: BlocListener<FilterCubit, FilterState>(
//         listener: (context, state) {
//           // ✅ عندما يتم تحميل المنتجات المفلترة، نعرضها
//           if (state is FilterLoaded) {
//             // يمكنك هنا تحديث الـ CategoriesCubit أو عمل أي شيء آخر
//             // لكن الأفضل نعرض المنتجات مباشرة
//           }
//         },
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 const SearchBarWithFiltter(),
//                 CategoryTabBuilder(incomingIndex: widget.incomingIndex),
//                 const SizedBox(height: 10),
                
//                 // ✅ نعرض المنتجات بناءً على حالة الفلتر
//                 Expanded(
//                   child: BlocBuilder<FilterCubit, FilterState>(
//                     builder: (context, filterState) {
//                       // إذا كان هناك فلتر نشط
//                       if (filterState is FilterLoaded && 
//                           filterState.appliedFilter != null) {
//                         // اعرض المنتجات المفلترة
//                         final products = filterState.products.products?? [];
                        
//                         if (products.isEmpty) {
//                           return const Center(
//                             child: Text('No products found'),
//                           );
//                         }
                        
//                         // TODO: هنا لازم تعدل ProductCardBuilder عشان ياخد المنتجات
//                         // أو تعمل widget جديد يعرض المنتجات المفلترة
//                         return GridView.builder(
//                           padding: const EdgeInsets.all(16),
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             childAspectRatio: 0.75,
//                             crossAxisSpacing: 16,
//                             mainAxisSpacing: 16,
//                           ),
//                           itemCount: products.length,
//                           itemBuilder: (context, index) {
//                             final product = products[index];
//                             return Card(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     flex: 3,
//                                     child: Container(
                                      
//                                       decoration: BoxDecoration(
//                                         color: Colors.grey[200],
//                                         borderRadius: const BorderRadius.vertical(
//                                           top: Radius.circular(12),
//                                         ),
//                                       ),
//                                       child: product.imgCover != null
//                                           ? Image.network(
//                                               product.imgCover!,
//                                               fit: BoxFit.cover,
//                                               width: double.infinity,
//                                             )
//                                           : const Icon(Icons.image),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           product.title ?? '',
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                         Text(
//                                           '${product.price ?? 0} EGP',
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       }
                      
//                       // إذا لم يكن هناك فلتر، اعرض المنتجات العادية
//                       return const ProductCardBuilder();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             FilterBottom(selectedSort: selectedSort, onTap: _showFilterSheet),
//           ],
//         ),
//       ),
//     );
//   }
// }