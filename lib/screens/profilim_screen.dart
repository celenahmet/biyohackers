import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProfilimScreen extends StatefulWidget {
  const ProfilimScreen({super.key});

  @override
  State<ProfilimScreen> createState() => _ProfilimScreenState();
}

class _ProfilimScreenState extends State<ProfilimScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _referrer;
  String? _lastLogin;
  int _totalLogins = 0;
  int _quizCount = 0;
  bool _isEditing = false;
  final List<String> _referrerOptions = [
    'Sosyal Medya',
    'Arkadaş Tavsiyesi',
    'Uygulama Mağazaları',
    'Okul ve Öğretmen',
    'Diğer'
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null) {
        _nameController.text = data['displayName'] ?? '';
        _schoolController.text = data['school'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _emailController.text = data['email'] ?? '';
        _referrer = data['referrer'];
        _quizCount = data['quizCompleted'] ?? 0;
        _lastLogin = data['lastLogin'];
        _totalLogins = data['totalLogins'] ?? 0;

        await _firestore.collection('users').doc(user.uid).set({
          'lastLogin': DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now().toLocal()) + ' (UTC+3)',
          'totalLogins': _totalLogins + 1,
        }, SetOptions(merge: true));

        setState(() {});
      }
    }
  }

  Future<void> _saveUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'displayName': _nameController.text.trim(),
        'school': _schoolController.text.trim(),
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        'referrer': _referrer,
      }, SetOptions(merge: true));
    }
  }

  void _handleDownloadRequest() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Veri İndirme Talebi Alındı"),
        content: const Text("Talebiniz alınmıştır. E-posta adresinize konuyla ilgili bilgilendirme yapılacaktır."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tamam"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              if (mounted) Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset('assets/logo.png', height: 100),
              const SizedBox(height: 8),
              Text(
                'Profil Bilgileri',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: isDark ? Colors.amber : Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildField(Icons.person, 'Ad Soyad', _nameController),
              _buildField(Icons.school, 'Eğitim Kurumu', _schoolController),
              _buildField(Icons.phone, 'Telefon', _phoneController),
              _buildField(Icons.email, 'E-posta', _emailController),
              _buildDropdownField(),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_isEditing) {
                    await _saveUserData();
                    setState(() => _isEditing = false);
                  } else {
                    setState(() => _isEditing = true);
                  }
                },
                icon: Icon(_isEditing ? Icons.save : Icons.edit),
                label: Text(_isEditing ? "Kaydet" : "Bilgileri Düzenle"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoCard(Icons.star, 'Toplam Quiz Katılımı', '$_quizCount tamamlandı'),
              _buildInfoCard(Icons.calendar_today, 'Son Giriş', _lastLogin ?? 'Bilinmiyor'),
              _buildInfoCard(Icons.login, 'Toplam Giriş', '$_totalLogins kez'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _handleDownloadRequest,
                icon: const Icon(Icons.download),
                label: const Text("Verileri İndirme Talebi"),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  final user = _auth.currentUser;
                  if (user != null) {
                    await _firestore.collection('users').doc(user.uid).delete();
                    await user.delete();
                    if (mounted) Navigator.pushReplacementNamed(context, '/');
                  }
                },
                icon: const Icon(Icons.delete_forever),
                label: const Text("Hesabı Sil"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(IconData icon, String label, TextEditingController controller, {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        enabled: _isEditing && enabled,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: _referrer,
        onChanged: _isEditing ? (val) => setState(() => _referrer = val) : null,
        items: _referrerOptions.map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
        decoration: const InputDecoration(
          labelText: 'Bizi nereden duydunuz?',
          prefixIcon: Icon(Icons.info_outline),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      color: isDark ? Colors.blueGrey.shade800 : Colors.deepPurple.shade50,
      child: ListTile(
        leading: Icon(icon, color: Colors.amber),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
