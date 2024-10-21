import 'package:flutter/material.dart';

class DeviceDetails extends StatelessWidget {
  const DeviceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Model', 'Unknown'),
          _buildInfoRow('Firmware', 'Unknown'),
          _buildInfoRow('SSID', ''),
          _buildInfoRow('WiFi Strength', '0 dBm'),
          _buildInfoRow('IP Address', '172.16.1.123'),
          _buildInfoRow('MAC Address', 'ECDA3B61C944'),
          _buildInfoRow('Serial Number', ''),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
