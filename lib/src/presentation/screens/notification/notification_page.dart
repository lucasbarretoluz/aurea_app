import 'package:aurea_app/src/data/models/notification/notification_model.dart';
import 'package:aurea_app/src/logic/cubit/notification_list/notification_list_cubit.dart';
import 'package:aurea_app/src/presentation/screens/notification/widgets/notification_card.dart';
import 'package:aurea_app/src/presentation/screens/notification/widgets/notification_empty_state.dart';
import 'package:aurea_app/src/presentation/screens/notification/widgets/notification_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<NotificationListCubit>()..fetchNotifications(),
      child: const NotificationView(),
    );
  }
}

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _markAsRead(NotificationModel notification) {
    context.read<NotificationListCubit>().markAsRead(notification.idNotification);
  }

  void _markAllAsRead() {
    context.read<NotificationListCubit>().markAllAsRead();
  }

  void _deleteNotification(NotificationModel notification) {
    context.read<NotificationListCubit>().deleteNotification(notification.idNotification);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notificação removida'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildBody(
    NotificationListState state,
    List<NotificationModel> notifications,
    ColorScheme colorScheme,
  ) {
    if (state.runtimeType.toString().contains('Loading') ||
        state.runtimeType.toString().contains('Initial')) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.runtimeType.toString().contains('Error')) {
      final errorMessage = (state as dynamic).message ?? 'Erro desconhecido';
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar notificações',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () =>
                    context.read<NotificationListCubit>().refresh(),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    if (notifications.isEmpty) {
      return const NotificationEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<NotificationListCubit>().fetchNotifications();
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationCard(
            notification: notification,
            onTap: () {
              if (!notification.isRead) {
                _markAsRead(notification);
              }
            },
            onDismissed: () => _deleteNotification(notification),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary.withValues(alpha: 0.05),
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: BlocBuilder<NotificationListCubit, NotificationListState>(
              builder: (context, state) {
                final notifications = (state.runtimeType.toString().contains('Loaded'))
                    ? (state as dynamic).notifications as List<NotificationModel>
                    : <NotificationModel>[];
                final unreadCount = notifications.where((n) => !n.isRead).length;

                return Column(
                  children: [
                    NotificationHeader(
                      unreadCount: unreadCount,
                      onMarkAllAsRead: _markAllAsRead,
                    ),
                    Expanded(
                      child: _buildBody(state, notifications, colorScheme),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
