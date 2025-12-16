// lib/features/applications/sampleTracking/pages/sample_tracking_report_page.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SampleTrackingReportPage extends StatefulWidget {
  const SampleTrackingReportPage({super.key});

  @override
  State<SampleTrackingReportPage> createState() =>
      _SampleTrackingReportPageState();
}

class _SampleTrackingReportPageState
    extends State<SampleTrackingReportPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Tracking Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCards(),
            const SizedBox(height: 24),
            _buildEfficiencyChart(),
          ],
        ),
      ),
    );
  }

  // ---------------- SUMMARY ----------------

  Widget _buildSummaryCards() {
    return Row(
      children: [
        _summaryCard('Target Efficiency', '95%', Icons.flag_outlined),
        const SizedBox(width: 12),
        _summaryCard('Avg Actual', '88%', Icons.trending_up),
        const SizedBox(width: 12),
        _summaryCard('Operators', '24', Icons.groups_outlined),
      ],
    );
  }

  Widget _summaryCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 28, color: Colors.blue),
              const SizedBox(height: 8),
              Text(value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(title, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- CHART ----------------

  Widget _buildEfficiencyChart() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly Efficiency Report',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  return LineChart(
                    _chartData(animationValue: _controller.value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _chartData({required double animationValue}) {
    return LineChartData(
      minX: 1,
      maxX: 30,
      minY: 70,
      maxY: 100,
      gridData: FlGridData(show: true),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 5,
            getTitlesWidget: (value, _) =>
                Text('${value.toInt()}%'),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 5,
            getTitlesWidget: (value, _) =>
                Text(value.toInt().toString()),
          ),
        ),
      ),
      lineBarsData: [
        _targetLine(animationValue),
        _actualLine(animationValue),
      ],
    );
  }

  // ---------------- LINES ----------------

  LineChartBarData _targetLine(double t) {
    return LineChartBarData(
      spots: List.generate(
        30,
            (i) => FlSpot(
          (i + 1).toDouble(),
          95 * t,
        ),
      ),
      isCurved: true,
      barWidth: 2.5,
      color: Colors.green,
      dotData: FlDotData(show: false),
      dashArray: [6, 4],
    );
  }

  LineChartBarData _actualLine(double t) {
    final actualData = [
      82, 84, 85, 83, 86, 87, 88, 90, 89, 91,
      90, 88, 87, 89, 90, 91, 92, 90, 89, 91,
      92, 93, 92, 91, 90, 89, 88, 87, 86, 88
    ];

    return LineChartBarData(
      spots: List.generate(
        actualData.length,
            (i) => FlSpot(
          (i + 1).toDouble(),
          actualData[i] * t,
        ),
      ),
      isCurved: true,
      barWidth: 3,
      color: Colors.blue,
      dotData: FlDotData(show: false),
    );
  }
}
