import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_tab_bar.dart';
import 'package:elevate_flower_app/features/orders_page/domain/entities/order_status.dart';
import 'package:elevate_flower_app/features/orders_page/presentation/view/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_flower_app/features/orders_page/presentation/view_model/cubit/orders_page_cubit.dart';
import 'package:elevate_flower_app/features/orders_page/presentation/view_model/cubit/orders_page_events.dart';
import 'package:elevate_flower_app/features/orders_page/presentation/view_model/cubit/orders_page_states.dart';
import 'package:go_router/go_router.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<OrdersPageCubit>()..doIntent(GetAllOrdersEvent()),
      child: const _OrdersPageView(),
    );
  }
}

class _OrdersPageView extends StatefulWidget {
  const _OrdersPageView();

  @override
  State<_OrdersPageView> createState() => _OrdersPageViewState();
}

class _OrdersPageViewState extends State<_OrdersPageView> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['Active', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.go(Routes.carScreen),
        ),
        title: const Text(
          'My orders',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Custom Tab Bar
          BlocBuilder<OrdersPageCubit, OrdersPageStates>(
            builder: (context, state) {
              return DefaultTabController(
                length: _tabs.length,
                child: TabBar(
                  onTap: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                  tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
                  labelColor: const Color(0xFFE91E63),
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  indicatorColor: const Color(0xFFE91E63),
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              );
            },
          ),

          const Divider(height: 1, thickness: 1),

          // Orders List
          Expanded(
            child: BlocBuilder<OrdersPageCubit, OrdersPageStates>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: Text('No orders yet')),
                  loading: () => _buildLoadingState(),
                  success: (ordersData) {
                    // ✅ FIX 1: Changed 'data' to 'ordersData' for clarity
                    // ✅ FIX 2: Check ordersData.orders.isEmpty instead of data.isEmpty
                    if (ordersData.orders.isEmpty) {
                      return const Center(child: Text('No orders found'));
                    }

                    // ✅ FIX 3: Use ordersData.orders instead of data.orders
                    // Filter orders based on selected tab
                    final filteredOrders = _selectedTabIndex == 0
                        ? ordersData.orders
                              .where(
                                (order) =>
                                    order.status != OrderStatus.delivered &&
                                    order.status != OrderStatus.cancelled,
                              )
                              .toList()
                        : ordersData.orders
                              .where(
                                (order) =>
                                    order.status == OrderStatus.delivered ||
                                    order.status == OrderStatus.cancelled,
                              )
                              .toList();

                    return _buildOrdersList(
                      filteredOrders,
                      isActive: _selectedTabIndex == 0,
                    );
                  },
                  error: (exception) => _buildErrorState(exception),
                  moreLoading: () => _buildLoadingState(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(color: Color(0xFFE91E63)),
    );
  }

  Widget _buildErrorState(Exception exception) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            exception.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<OrdersPageCubit>().doIntent(GetAllOrdersEvent());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE91E63),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List orders, {required bool isActive}) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              isActive ? 'No active orders' : 'No completed orders',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(order: orders[index], isActive: isActive);
      },
    );
  }
}
