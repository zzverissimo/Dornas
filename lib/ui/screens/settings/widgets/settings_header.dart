import 'package:dornas_app/ui/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  final String? photoUrl;

  const SettingsHeader({super.key, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          CustomContainer(
            width: double.infinity,
            height: 140,
            child: Image.asset(
              'assets/images/atardecer_dorna.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-1, 1),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 16),
              child: CustomContainer(
                width: 90,
                height: 90,
                borderRadius: BorderRadius.circular(45),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: photoUrl != null
                        ? Image.network(
                            photoUrl!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/foto_perfil.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
