import 'package:flutter/material.dart';

class HelpCenterDrawer extends StatefulWidget {
  const HelpCenterDrawer({super.key});

  @override
  State<HelpCenterDrawer> createState() => _HelpCenterDrawerState();
}

class _HelpCenterDrawerState extends State<HelpCenterDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    _controller.reverse().then((_) {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: _close,
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Material(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        width: width * 0.655,
                        height: height * 0.75,
                      ),
                      Positioned(
                        top: -6,
                        right: 0,
                        child: Container(
                          width: width * 0.64,
                          height: height * 0.75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 15,
                                offset: const Offset(-3, 0),
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 24.0,
                                  right: 24.0,
                                  top: MediaQuery.of(context).padding.top + 50.0,
                                  bottom: 16.0,
                                ),
                                child: Text(
                                  'Central de Ajuda',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 4.5,
                                  ),
                                ),
                              ),
                             
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 26),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 24),
                                    child: Container(
                                      height: 2.3,
                                      width: 50,
                                      color: Colors.black,
                                    ),
                                  ),
                                  _HelpCenterItem(
                                    title: 'Protocolo fotográfico',
                                    onTap: _close,
                                  ),
                                  _HelpCenterItem(
                                    title: 'Configurações de câmera semiprofissional',
                                    onTap: _close,
                                  ),
                                  _HelpCenterItem(
                                    title: 'Fotografando com o celular',
                                    onTap: _close,
                                  ),
                                  _HelpCenterItem(
                                    title: 'Linhas e referências',
                                    onTap: _close,
                                  ),
                                  _HelpCenterItem(
                                    title: 'Proporções dentárias',
                                    onTap: _close,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HelpCenterItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _HelpCenterItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
