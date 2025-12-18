import 'package:flutter/material.dart';

class SemiProfessionalCameraSettingsPage3 extends StatefulWidget {
  const SemiProfessionalCameraSettingsPage3({super.key});

  @override
  State<SemiProfessionalCameraSettingsPage3> createState() =>
      _SemiProfessionalCameraSettingsPage3State();
}

class _SemiProfessionalCameraSettingsPage3State
    extends State<SemiProfessionalCameraSettingsPage3> {
  bool _isFirstExpanded = false;
  bool _isSecondExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: const Text(
            'Veja abaixo nossas sugestões de configuração de câmera semiprofissional:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 35),
        _buildExpandableOption(
          title: 'Tenho uma câmera semiprofissional e um flash/estúdio',
          isExpanded: _isFirstExpanded,
          onTap: () {
            setState(() {
              _isFirstExpanded = !_isFirstExpanded;
            });
          },
          child: _buildFirstExpandedContent(),
        ),
        const SizedBox(height: 30),
        _buildExpandableOption(
          title: 'Tenho uma câmera semiprofissional, mas ',
          boldText: 'não tenho',
          titleSuffix: ' flash/estúdio',
          isExpanded: _isSecondExpanded,
          onTap: () {
            setState(() {
              _isSecondExpanded = !_isSecondExpanded;
            });
          },
          child: _buildSecondExpandedContent(),
        ),
      ],
    );
  }

  Widget _buildExpandableOption({
    required String title,
    String? boldText,
    String? titleSuffix,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(text: title),
                      if (boldText != null)
                        TextSpan(
                          text: boldText,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      if (titleSuffix != null) TextSpan(text: titleSuffix),
                    ],
                  ),
                ),
              ),
              Icon(
                isExpanded ? Icons.remove : Icons.add,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Divider(color: Colors.grey, thickness: 1, height: 1),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: isExpanded ? null : 0,
          child:
              isExpanded
                  ? Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: child,
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildFirstExpandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            border: Border.all(
              color: Colors.lightBlue.withOpacity(0.5),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: _buildTableHeader('ROSTO')),
                    _buildVerticalDivider(),
                    Expanded(child: _buildTableHeader('BOCA')),
                  ],
                ),
              ),
              _buildHorizontalDivider(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: _buildSettingItem('ISO 400')),
                    _buildVerticalDivider(),
                    Expanded(child: _buildSettingItem('ISO 100')),
                  ],
                ),
              ),
              _buildHorizontalDivider(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: _buildSettingItem('F8')),
                    _buildVerticalDivider(),
                    Expanded(child: _buildSettingItem('F22')),
                  ],
                ),
              ),
              _buildHorizontalDivider(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: _buildSettingItem('Obturador 1/80')),
                    _buildVerticalDivider(),
                    Expanded(
                      child: _buildSettingItem('Obturador: 1/160~1/200'),
                    ),
                  ],
                ),
              ),
              _buildHorizontalDivider(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: _buildSettingItem('Foco automático')),
                    _buildVerticalDivider(),
                    Expanded(child: _buildSettingItem('Foco manual')),
                  ],
                ),
              ),
              _buildHorizontalDivider(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: _buildSettingItem('Flash TTL')),
                    _buildVerticalDivider(),
                    Expanded(child: _buildSettingItem('Flash TTL')),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              height: 1.5,
            ),
            children: [
              const TextSpan(
                text: 'Sugestão',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text:
                    ' de configuração - teste diferentes variações, distâncias e posições de luz!',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecondExpandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
            children: [
              const TextSpan(text: 'Para as fotos aproximadas da '),
              TextSpan(
                text: 'boca',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text:
                    ', utilize as configurações descritas acima com o flash da sua câmera ',
              ),
              TextSpan(
                text: 'ativado',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: '. O flash acoplado à câmera terá '),
              TextSpan(
                text: 'potência',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text:
                    ' suficiente para iluminar as fotos, porém, sempre em um padrão de iluminação ',
              ),
              TextSpan(
                text: 'unidirecional',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text.rich(
          TextSpan(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
            children: [
              const TextSpan(
                text:
                    'Caso você busque uma iluminação mais difusa ou você queira variar as direções de luz nas fotos, terá de ',
              ),
              TextSpan(
                text: 'contar com outra fonte de luz externa à sua câmera',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: ', como um '),
              TextSpan(
                text: 'ring light',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const TextSpan(text: ' ou luzes de LED portáteis.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: double.infinity,
      color: Colors.grey.withOpacity(0.5),
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildHorizontalDivider() {
    return Divider(
      color: Colors.grey.withOpacity(0.5),
      thickness: 1,
      height: 1,
    );
  }
}
