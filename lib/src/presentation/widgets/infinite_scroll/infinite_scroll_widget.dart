import 'package:flutter/material.dart';

class InfiniteScrollWidget extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onLoadMore;
  final bool hasMoreData;
  final bool isLoading;
  final ScrollController? scrollController;
  final bool wrapInScrollView;

  const InfiniteScrollWidget({
    super.key,
    required this.child,
    required this.onLoadMore,
    required this.hasMoreData,
    required this.isLoading,
    this.scrollController,
    this.wrapInScrollView = false,
  });

  @override
  State<InfiniteScrollWidget> createState() => _InfiniteScrollWidgetState();
}

class _InfiniteScrollWidgetState extends State<InfiniteScrollWidget> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!_isLoadingMore &&
        widget.hasMoreData &&
        !widget.isLoading &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    await widget.onLoadMore();

    setState(() {
      _isLoadingMore = false;
    });
  }

  Widget _buildContent() {
    return Column(
      children: [
        widget.child,
        if (widget.isLoading || _isLoadingMore)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.wrapInScrollView) {
      return SingleChildScrollView(
        controller: _scrollController,
        child: _buildContent(),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo is ScrollEndNotification) {
          _scrollListener();
        }
        return false;
      },
      child: _buildContent(),
    );
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }
} 