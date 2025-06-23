class _BitkiHucresiOrganelleriState extends State<BitkiHucresiOrganelleri> {
  String secilenOrganel = 'Çekirdek';
  String organelBilgisi = 'Hücrenin yönetim merkezidir, DNA buradadır.';

  final Map<String, String> organelVerisi = {
    'Hücre Zarı': 'Madde giriş çıkışını sağlar.',
    'Hücre Çeperi': 'Bitki hücresine şekil verir ve korur.',
    'Sitoplazma': 'Organellerin içinde bulunduğu sıvıdır.',
    'Çekirdek': 'Hücrenin yönetim merkezidir, DNA buradadır.',
    'Mitokondri': 'Enerji (ATP) üretir.',
    'Koful': 'Atık depolar ve su dengesini sağlar.',
    'Kloroplast': 'Fotosentez yapar, sadece bitkilerde bulunur.',
  };

  void organelSec(String organel) {
    setState(() {
      secilenOrganel = organel;
      organelBilgisi = organelVerisi[organel] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Image.asset(
                'assets/bitki_hucresi.png',
                width: MediaQuery.of(context).size.width * 0.75,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: organelVerisi.keys.map((organel) {
                      return ElevatedButton(
                        onPressed: () => organelSec(organel),
                        child: Text(organel, textAlign: TextAlign.center),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  secilenOrganel,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  organelBilgisi,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
