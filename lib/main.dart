import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ─────────────────────────────────────────────
// TEMA & RENK PALETİ
// ─────────────────────────────────────────────
class AppColors {
  // Açık tema
  static const primary = Color(0xFF2E7D32);
  static const primaryLight = Color(0xFF43A047);
  static const surface = Color(0xFFF5F9F5);
  static const card = Colors.white;
  static const textPrimary = Color(0xFF1A1A2E);
  static const textSecondary = Color(0xFF6B7280);

  // Koyu tema
  static const darkPrimary = Color(0xFF4CAF50);
  static const darkSurface = Color(0xFF0F1923);
  static const darkCard = Color(0xFF1A2535);
  static const darkTextPrimary = Color(0xFFF0F4F0);
  static const darkTextSecondary = Color(0xFF9CA3AF);
}

void main() {
  runApp(const IlahiApp());
}

class IlahiApp extends StatelessWidget {
  const IlahiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bünyamin Efendi İlahileri',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.primary,
          surface: AppColors.surface,
        ),
        scaffoldBackgroundColor: AppColors.surface,
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: AppColors.card,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 1,
          centerTitle: true,
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: 0.2,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          hintStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.darkPrimary,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppColors.darkPrimary,
          surface: AppColors.darkSurface,
        ),
        scaffoldBackgroundColor: AppColors.darkSurface,
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: AppColors.darkCard,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 1,
          centerTitle: true,
          backgroundColor: AppColors.darkSurface,
          foregroundColor: AppColors.darkTextPrimary,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.darkTextPrimary,
            letterSpacing: 0.2,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkCard,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF2A3545)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF2A3545)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                const BorderSide(color: AppColors.darkPrimary, width: 1.5),
          ),
        ),
      ),
      home: const MainPage(),
    );
  }
}
// ─────────────────────────────────────────────
// GALERİ SAYFASI
// ─────────────────────────────────────────────
class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  // Buraya assets/images içindeki dosya adlarını yazın
  final List<String> _images = [
    'assets/images/bunyamin_efendi.jpg',
    'assets/images/bunyamin_efendim_dua.jpg', // Sizin ekleyeceğiniz 1. fotoğraf
    'assets/images/bunyamin_efendim_sahra.jpg', // Sizin ekleyeceğiniz 2. fotoğraf
    // 'assets/images/resim2.jpg',
    // 'assets/images/resim3.jpg',
    // istediğiniz kadar ekleyin
  ];

  void _openFullscreen(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FullscreenImagePage(
          images: _images,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_images.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.photo_library_outlined,
                size: 72,
                color: isDark
                    ? AppColors.darkTextSecondary.withOpacity(0.3)
                    : AppColors.textSecondary.withOpacity(0.2)),
            const SizedBox(height: 16),
            Text(
              'Henüz fotoğraf eklenmedi',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _openFullscreen(context, index),
          child: Hero(
            tag: 'gallery_$index',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                _images[index],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Icon(Icons.broken_image_outlined,
                        size: 40, color: AppColors.primary),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// TAM EKRAN GÖRÜNTÜLEYICI
// ─────────────────────────────────────────────
class _FullscreenImagePage extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullscreenImagePage({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullscreenImagePage> createState() => _FullscreenImagePageState();
}

class _FullscreenImagePageState extends State<_FullscreenImagePage> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          '${_currentIndex + 1} / ${widget.images.length}',
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        itemBuilder: (context, index) {
          return Hero(
            tag: 'gallery_$index',
            child: InteractiveViewer(
              child: Center(
                child: Image.asset(
                  widget.images[index],
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.broken_image_outlined,
                    size: 64,
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// ─────────────────────────────────────────────
// İLAHİ & SOHBETLER SAYFASI (YouTube linkleri)
// ─────────────────────────────────────────────
class SohbetlerPage extends StatefulWidget {
  const SohbetlerPage({super.key});

  @override
  State<SohbetlerPage> createState() => _SohbetlerPageState();
}

class _SohbetlerPageState extends State<SohbetlerPage> {
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();

  // youtubeUrl'i olan ve "null" olmayan ilahileri filtrele
  List<Ilahi> get _withYoutube => allIlahiler
      .where((i) =>
          i.youtubeUrl != null &&
          i.youtubeUrl!.isNotEmpty &&
          i.youtubeUrl != 'null' &&
          i.title.toLowerCase().contains(_searchText.toLowerCase()))
      .toList();

  Future<void> _openYoutube(String url) async {
  final uri = Uri.parse(url);
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hata: $e'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }
}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final list = _withYoutube;

    return Column(
      children: [
        // Arama
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: (v) => setState(() => _searchText = v),
            decoration: InputDecoration(
              hintText: 'İlahi veya sohbet ara...',
              prefixIcon: const Icon(Icons.search_rounded, size: 20),
              suffixIcon: _searchText.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close_rounded, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchText = '');
                      },
                    )
                  : null,
            ),
          ),
        ),
        // Sayı
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
          child: Row(
            children: [
              Text(
                '${list.length} içerik',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        // Liste
        Expanded(
          child: list.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_circle_outline_rounded,
                          size: 72,
                          color: isDark
                              ? AppColors.darkTextSecondary.withOpacity(0.3)
                              : AppColors.textSecondary.withOpacity(0.2)),
                      const SizedBox(height: 16),
                      Text(
                        'İçerik bulunamadı',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final ilahi = list[index];
                    return _SohbetCard(
                      ilahi: ilahi,
                      index: index + 1,
                      isDark: isDark,
                      onTap: () => _openYoutube(ilahi.youtubeUrl ?? ""),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _SohbetCard extends StatelessWidget {
  final Ilahi ilahi;
  final int index;
  final bool isDark;
  final VoidCallback onTap;

  const _SohbetCard({
    required this.ilahi,
    required this.index,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark
              ? const Color(0xFF2A3545)
              : const Color(0xFFF0F0F0),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              // Sol taraftaki YouTube Oynatma İkonu
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.play_circle_filled_rounded,
                    color: Colors.red, size: 28),
              ),
              const SizedBox(width: 12),
              // Başlık + Cilt Bilgisi
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ilahi.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Cilt ${ilahi.ciltNo}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Sağ taraftaki mükerrer YouTube rozeti kaldırıldı.
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MODEL
// ─────────────────────────────────────────────
class Ilahi {
  final int id;
  final int ciltNo;
  final String title;
  final String author;
  final String category;
  final String lyricsPath;
  final String audioPath;
  final String? youtubeUrl; // ← YENİ

  const Ilahi({
    required this.id,
    required this.ciltNo,
    required this.title,
    required this.author,
    required this.category,
    required this.lyricsPath,
    required this.audioPath,
     this.youtubeUrl = "null",
  });

  bool get hasAudio => audioPath != 'null' && audioPath.isNotEmpty;
}

// ─────────────────────────────────────────────
// VERİ LİSTESİ — DEĞİŞMEDİ (sadece ilk birkaçı örnek)
// ─────────────────────────────────────────────
const List<Ilahi> allIlahiler = [
  Ilahi(
    id: 1,
    ciltNo: 1,
    title: "DÜNYAYA GELİŞ",
    author: "Bünyamin Yıldırım Efendi Hazretleri",
    category: "İlahi",
    audioPath: "null",
    lyricsPath: "assets/text/1_Dunyaya_Gelis.txt",
       
  
  ),
  

  // Yeni ilahileri buraya ekle.
  Ilahi(
    id: 2,
    ciltNo: 1,
    title: "MİM MUHAMMED",
    author: "Bünyamin Yıldırım Efendi Hazretleri",
    category: "İlahi",
    audioPath: "null",
    lyricsPath: "assets/text/2_Mim_Muhammed.txt",
    youtubeUrl: "https://www.youtube.com/watch?v=cUioTuUW5_I&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=6"
    
  
  ),
  Ilahi(
    id: 3,
    ciltNo: 1,
    title: "BENİM GÖNLÜM TOPRAK İLE BERABER",
    author: "Bünyamin Yıldırım Efendi Hazretleri",
    category: "İlahi",
    audioPath: "null",
    lyricsPath: "assets/text/3_Benim_gonlum_toprak_ile_beraber.txt",
    
  ),
  Ilahi(
    id: 4,
    ciltNo: 1,
    title: "SEN DE TOPRAKTASIN BEN DE",
    author: "Bünyamin Yıldırım Efendi Hazretleri",
    category: "İlahi",
    audioPath: "null",
    lyricsPath: "assets/text/4_Sende_topraktasın_ben_de.txt",
    ),
  Ilahi(
    id: 5,
    ciltNo: 1,
    title: "BENİM ATAM - BENİM BABAM",
    author: "Bünyamin Yıldırım Efendi Hazretleri",
    category: "İlahi",
    audioPath: "null",
    lyricsPath: "assets/text/5_Benim_atam_benim_babam.txt",
    ),
    Ilahi(
  id: 6,
  ciltNo: 1,
  title: "BENİM ANAM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/6_Benim_Anam.txt",
),
Ilahi(
  id: 7,
  ciltNo: 1,
  title: "ÖLMEZ BENİM ŞEYHİM ÖLMEZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/7_Olmez_benim_seyhim_olmez.txt",
),
Ilahi(
  id: 8,
  ciltNo: 1,
  title: "BENİ BANA SORMAN ŞEYHİME SORUN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/8_Beni_bana_sorman_seyhime_sorun.txt",
),
Ilahi(
  id: 9,
  ciltNo: 1,
  title: "MÜRŞİDİMİN BİR NAZARI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/9_mursidimin_bir_nazari.txt",
),
Ilahi(
  id: 10,
  ciltNo: 1,
  title: "İKİ CİHAN KUTBU ÜSTADIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/10_iki_cihan_kutbu_ustadim.txt",
),
Ilahi(
  id: 11,
  ciltNo: 1,
  title: "BEN ŞEYHİMİ YİTİRMEDİM ARAYIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/11_Ben_seyhimi_yitirmedim_arayim.txt",
),
Ilahi(
  id: 12,
  ciltNo: 1,
  title: "HİMMET EYLE ŞEYHİM BANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/12_himmet_eyle_seyhim_bana.txt",
),
Ilahi(
  id: 13,
  ciltNo: 1,
  title: "DERGAHIMIZ İHRAMCININ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/13_Dergahimiz_IHRAMCININ.txt",
),
Ilahi(
  id: 14,
  ciltNo: 1,
  title: "GÖNLÜMÜN SULTANI İHRAMCIZADE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/14_GONLUMUN_SULTANI_IHRAMCIZADE.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=5joNEy7TLjg&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=21"
),
Ilahi(
  id: 15,
  ciltNo: 1,
  title: "BEN ŞEYHİMİN HİMMETİYLE GEZERİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/15_BEN_SEYHIMIN_HIMMETIYLE_GEZERIM.txt",
),
Ilahi(
  id: 16,
  ciltNo: 1,
  title: "BENİM GÖNLÜM EFENDİMDEN AYRI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/16_BENIM_GONLUM_EFENDIMDEN_AYRI.txt",
),
Ilahi(
  id: 17,
  ciltNo: 1,
  title: "BENİM GÖNLÜM EFENDİMİ ARZULAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/17_BENIM_GONLUM_EFENDIMI_ARZULAR.txt",
),
Ilahi(
  id: 18,
  ciltNo: 1,
  title: "İHRAMCIZADENİN BÜLBÜLÜYÜZ BİZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/18_IHRAMCIZADENIN_BULBULUYUZ_BIZ.txt",
),
Ilahi(
  id: 19,
  ciltNo: 1,
  title: "YOLLARINDAN HAKİ TOPRAK KOKUSU",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/19_YOLLARINDAN_HAKI_TOPRAK_KOKUSU.txt",
),
Ilahi(
  id: 20,
  ciltNo: 1,
  title: "BENİ BANA SORMAN ŞEYHİME SOR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/20_BENI_BANA_SORMAN_SEYHIME_SOR.txt",
),
Ilahi(
  id: 21,
  ciltNo: 1,
  title: "ŞEYHİM SENİN HİMMETİNLE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/21_SEYHIM_SENIN_HIMMETINLE.txt",
),
Ilahi(
  id: 22,
  ciltNo: 1,
  title: "HANE SENİN HANEDANIN NE OLDU",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/22_HANE_SENIN_HANEDANIN_NE_OLDU.txt",
),
Ilahi(
  id: 23,
  ciltNo: 1,
  title: "ŞEYHİMDEN SİZE SELAM GETİRDİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/23_SEYHIMDEN_SIZE_SELAM_GETIRDIM.txt",
),
Ilahi(
  id: 24,
  ciltNo: 1,
  title: "HİMMET ET İHRAMCIZADE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/24_HIMMET_ET_IHRAMCIZADE.txt",
),
Ilahi(
  id: 25,
  ciltNo: 1,
  title: "İHRAMCIZADENİN BÜLBÜLÜYÜZ BİZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/25_IHRAMCIZADENIN_BULBULUYUZ_BIZ.txt",
),
Ilahi(
  id: 26,
  ciltNo: 1,
  title: "BANA ŞEYHİM YETER BANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/26_BANA_SEYHIM_YETER_BANA.txt",
),
Ilahi(
  id: 27,
  ciltNo: 1,
  title: "BENİ BANA SORMAN ŞEYHİME SORUN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/27_BENI_BANA_SORMAN_SEYHIME_SORUN.txt",
),
Ilahi(
  id: 28,
  ciltNo: 1,
  title: "ŞEYHİM SENDEN AYRILAMAM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/28_SEYHIM_SENDEN_AYRILAMAM.txt",
),
Ilahi(
  id: 29,
  ciltNo: 1,
  title: "PİR İLE GÖNLÜM YAR İLE GÖNLÜM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/29_PIR_ILE_GONLUM_YAR_ILE_GONLUM.txt",
),
Ilahi(
  id: 30,
  ciltNo: 1,
  title: "DERDE DERMANIM YARİMİN GÖNLÜ PİRİMİN GÖNLÜ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/30_DERDE_DERMANIM_YARIMIN_GONLU_PIRIMIN_GONLU.txt",
),
Ilahi(
  id: 31,
  ciltNo: 1,
  title: "İÇERİZ BADEYİ PİRİN ELİNDEN EDERİZ SOHBETİ ONUN DİLİNDEN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/31_ICERIZ_BADEYI_PIRIN_ELINDEN_EDERIZ_SOHBETI_ONUN_DILINDEN.txt",
),
Ilahi(
  id: 32,
  ciltNo: 1,
  title: "NAKŞI DERGAHINA GİTMEYEYİM Mİ BÜLBÜL OLUP DALINDA ÖTMEYEYİM Mİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/32_NAKSI_DERGAHINA_GITMEYEYIM_MI_BULBUL_OLUP_DALINDA_OTMEYEYIM_MI.txt",
),
Ilahi(
  id: 33,
  ciltNo: 1,
  title: "BENİM ŞEYHİM GÖNLÜMDEDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/33_BENIM_SEYHIM_GONLUMDEDIR.txt",
),
Ilahi(
  id: 34,
  ciltNo: 1,
  title: "PİRİN HİMMETİNE MUHTAÇ BU DERGAH",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/34_PIRIN_HIMMETINE_MUHTAC_BU_DERGAH.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=uEzEvajWPG0&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=12"
),
Ilahi(
  id: 35,
  ciltNo: 1,
  title: "EY PİRANIM GÖNLÜMDESİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/35_EY_PIRANIM_GONLUMDESIN.txt",
),
Ilahi(
  id: 36,
  ciltNo: 1,
  title: "GEL EFENDİM GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/36_GEL_EFENDIM_GEL.txt",
),
Ilahi(
  id: 37,
  ciltNo: 1,
  title: "HUZUR NAKŞI DEMİNE GEL GÖNÜL HUZUR DEMİNE GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/37_HUZUR_NAKSI_DEMINE_GEL_GONUL_HUZUR_DEMINE_GEL.txt",
),
Ilahi(
  id: 38,
  ciltNo: 1,
  title: "GELİN HAKKIN DERGAHINA GİDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/38_GELIN_HAKKIN_DERGAHINA_GIDELIM.txt",
),
Ilahi(
  id: 39,
  ciltNo: 1,
  title: "DEMİ BU DERGAHIN DEMİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/39_DEMI_BU_DERGAHIN_DEMI.txt",
),
Ilahi(
  id: 40,
  ciltNo: 1,
  title: "BEN SİVASİ ŞERİFTEYİM MİM İLE ELİFTEYİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/40_BEN_SIVASI_SERIFTEYIM_MIM_ILE_ELIFTEYIM.txt",
),
Ilahi(
  id: 41,
  ciltNo: 1,
  title: "AŞIKLAR BADEYİ YARİNDEN İÇER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/41_ASIKLAR_BADEYI_YARINDEN_ICER.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=WzRQ65XgJlk&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=10"
),
Ilahi(
  id: 42,
  ciltNo: 1,
  title: "GÖNLÜMDESİN YA MUHAMMED",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/42_GONLUMDESIN_YA_MUHAMMED.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=_oQmgeEq4Ow&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=2"
),
Ilahi(
  id: 43,
  ciltNo: 1,
  title: "YETİŞ BU İMDADA GEL YA MUHAMMED",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/43_YETIS_BU_IMDADA_GEL_YA_MUHAMMED.txt",
),
Ilahi(
  id: 44,
  ciltNo: 1,
  title: "BENİM GÖNLÜM MUHAMMEDDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/44_BENIM_GONLUM_MUHAMMEDDE.txt",
),
Ilahi(
  id: 45,
  ciltNo: 1,
  title: "MUHAMMED DÜNYAYA GELDİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/45_MUHAMMED_DUNYAYA_GELDI.txt",
),
Ilahi(
  id: 46,
  ciltNo: 1,
  title: "GARİP ÜMMETİM DER AĞLAR MUHAMMED MEVLAYA ARZUHAL SUNAR MUHAMMED",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/46_GARIP_UMMETIM_DER_AGLAR_MUHAMMED_MEVLAYA_ARZUHAL_SUNAR_MUHAMMED.txt",
),
Ilahi(
  id: 47,
  ciltNo: 1,
  title: "CANDAN MUHAMMEDİM GÜZEL AHMEDİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/47_CANDAN_MUHAMMEDIM_GUZEL_AHMEDIM.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=_X870Kh-loY&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=18"
),
Ilahi(
  id: 48,
  ciltNo: 1,
  title: "YETİŞ YA MUHAMMED ŞEFAAT BİZE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/48_YETIS_YA_MUHAMMED_SEFEAT_BIZE.txt",
),
Ilahi(
  id: 49,
  ciltNo: 1,
  title: "YETİŞ YA MUHAMMED GEL BİZE BİZE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/49_YETIS_YA_MUHAMMED_GEL_BIZE_BIZE.txt",
),
Ilahi(
  id: 50,
  ciltNo: 1,
  title: "YETİŞ YA MUHAMMED İMDADIMA GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/50_YETIS_YA_MUHAMMED_IMDADIMA_GEL.txt",
),
Ilahi(
  id: 51,
  ciltNo: 1,
  title: "MÜRŞİDİ KAMİLE VARMADAN OLMAZ TARİKİ YEZDANA GİRMEDEN OLMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/51_MURSIDI_KAMILE_VARMADAN_OLMAZ_TARIKI_YEZDANA_GIRMEDEN_OLMAZ.txt",
),
Ilahi(
  id: 52,
  ciltNo: 1,
  title: "TANI DERVİŞANI TANI HOR GÖRME SAKIN ONU",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/52_TANI_DERVISHANI_TANI_HOR_GORME_SAKIN_ONU.txt",
),
Ilahi(
  id: 53,
  ciltNo: 1,
  title: "ZİKRİNİ BİL ZİKRİNİ BİL NİMET İLE ŞÜKRÜNÜ BİL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/53_ZIKRINI_BIL_ZIKRINI_BIL_NIMET_ILE_SUKRUNU_BIL.txt",
),
Ilahi(
  id: 54,
  ciltNo: 1,
  title: "BENİM BU YANDIĞIM DERT GÖNÜL DERDİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/54_BENIM_BU_YANDIGIM_DERT_GONUL_DERDI.txt",
),
Ilahi(
  id: 55,
  ciltNo: 1,
  title: "BU GARİP GÖNLÜME BAYRAM O BAYRAM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/55_BU_GARIP_GONLUME_BAYRAM_O_BAYRAM.txt",
),
Ilahi(
  id: 56,
  ciltNo: 1,
  title: "BEN MEVLAM SEVENLERİ SEVERİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/56_BEN_MEVLAM_SEVENLERI_SEVERIM.txt",
),
Ilahi(
  id: 57,
  ciltNo: 1,
  title: "ÖMRÜM KADRİNİ BİLMEDİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/57_OMRUM_KADRINI_BILMEDIM.txt",
),
Ilahi(
  id: 58,
  ciltNo: 1,
  title: "BEN YANARIM GÖNLÜM YANAR BU DERDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/58_BEN_YANARIM_GONLUM_YANAR_BU_DERDE.txt",
),
Ilahi(
  id: 59,
  ciltNo: 1,
  title: "AYLAR BİTER GÜNLER BİTER DERT BİTMEZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/59_AYLAR_BITER_GUNLER_BITER_DERT_BITMEZ.txt",
),
Ilahi(
  id: 60,
  ciltNo: 1,
  title: "BENİM GÖNLÜM BERAT DİLER AF DİLER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/60_BENIM_GONLUM_BERAT_DILER_AF_DILER.txt",
),
Ilahi(
  id: 61,
  ciltNo: 1,
  title: "SAHİP OL GÖNLÜNÜ YAD ELE VERME",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/61_SAHIP_OL_GONLUNU_YAD_ELE_VERME.txt",
),
Ilahi(
  id: 62,
  ciltNo: 1,
  title: "BİZİ GAFİL SANMA BİZİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/62_BIZI_GAFIL_SANMA_BIZI.txt",
),
Ilahi(
  id: 63,
  ciltNo: 1,
  title: "AYIK OL LAYIK OL HİMMET AL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/63_AYIK_OL_LAYIK_OL_HIMMET_AL.txt",
),
Ilahi(
  id: 64,
  ciltNo: 1,
  title: "AŞKINI VER ŞEVKİNİ VER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/64_ASKINI_VER_SEVKINI_VER.txt",
),
Ilahi(
  id: 65,
  ciltNo: 1,
  title: "GEL GÖR BENİ AŞK NEYLEDİ GÖR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/65_GEL_GOR_BENI_ASK_NEYLEDI_GOR.txt",
),
Ilahi(
  id: 66,
  ciltNo: 1,
  title: "BURA AŞIKLARIN DEMHANESİDİR HASRET DERTLERİNİN EMHANESİDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/66_BURA_ASIKLARIN_DEMHANESIDIR_HASRET_DERTLERININ_EMHANESIDIR.txt",
),
Ilahi(
  id: 67,
  ciltNo: 1,
  title: "BEN AĞLAYIM SİZ AĞLAYIN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/67_BEN_AGLAYIM_SIZ_AGLAYIN.txt",
),
Ilahi(
  id: 68,
  ciltNo: 1,
  title: "HAYIF BANA YAZIK BANA VAH BANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/68_HAYIF_BANA_YAZIK_BANA_VAH_BANA.txt",
),
Ilahi(
  id: 69,
  ciltNo: 1,
  title: "BİZİM EVLİYADAN NAZARIMIZ VAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/69_BIZIM_EVLIYADAN_NAZARIMIZ_VAR.txt",
),
Ilahi(
  id: 70,
  ciltNo: 1,
  title: "BİL ERENLER SOHBETİNDE ERENLERİN SOHBETİNDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/70_BIL_ERENLER_SOHBETINDE_ERENLERIN_SOHBETINDE.txt",
),
Ilahi(
  id: 71,
  ciltNo: 1,
  title: "AYIK OL GÖNLÜM AYIK OL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/71_AYIK_OL_GONLUM_AYIK_OL.txt",
),
Ilahi(
  id: 72,
  ciltNo: 1,
  title: "BİZDEN UZAK KAÇMAN YAKLAŞIN BİZE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/72_BIZDEN_UZAK_KACMAN_YAKLASIN_BIZE.txt",
),
Ilahi(
  id: 73,
  ciltNo: 1,
  title: "BEN GARİBİM GÖNLÜM GARİP",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/73_BEN_GARIBIM_GONLUM_GARIP.txt",
),
Ilahi(
  id: 74,
  ciltNo: 1,
  title: "GEZDİĞİN YERLERDE BİZİ HATIRLA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/74_GEZDIGIN_YERLERDE_BIZI_HATIRLA.txt",
),
Ilahi(
  id: 75,
  ciltNo: 1,
  title: "KALBİM GÖNLÜMÜ ALDA BERİ GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/75_KALBIM_GONLUMU_ALDA_BERI_GEL.txt",
),
Ilahi(
  id: 76,
  ciltNo: 1,
  title: "NE SEN VAR NE BEN VAR BİR ALLAHIM VAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/76_NE_SEN_VAR_NE_BEN_VAR_BIR_ALLAHIM_VAR.txt",
),
Ilahi(
  id: 77,
  ciltNo: 1,
  title: "GETİR SOHBET SOFRASINA ÇIKAR SOHBET SOFRASINA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/77_GETIR_SOHBET_SOFRASINA_CIKAR_SOHBET_SOFRASINA.txt",
),
Ilahi(
  id: 78,
  ciltNo: 1,
  title: "BİZİM ELLER BİZİM ELLER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/78_BIZIM_ELLER_BIZIM_ELLER.txt",
),
Ilahi(
  id: 79,
  ciltNo: 1,
  title: "AĞIZ BENİM DEĞİL DİL BENİM DEĞİL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/79_AGIZ_BENIM_DEGIL_DIL_BENIM_DEGIL.txt",
),
Ilahi(
  id: 80,
  ciltNo: 1,
  title: "YALVAR KUL ALLAHA YALVAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/80_YALVAR_KUL_ALLAHA_YALVAR.txt",
),
Ilahi(
  id: 81,
  ciltNo: 1,
  title: "BİZİ YAD ELE SORMAYIN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/81_BIZI_YAD_ELE_SORMAYIN.txt",
),
Ilahi(
  id: 82,
  ciltNo: 1,
  title: "AŞIK OLDUM GÜLE AŞIK",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/82_ASIK_OLDUM_GULE_ASIK.txt",
),
Ilahi(
  id: 830,
  ciltNo: 1,
  title: "EY GÖNÜL DOSTLARI SEFA GELDİNİZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/83_0_EY_GONUL_DOSTLARI_SEFA_GELDINIZ.txt",
),
Ilahi(
  id: 831,
  ciltNo: 1,
  title: "AYIK OL GÖNLÜM AYIK OL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/83_1_AYIK_OL_GONLUM_AYIK_OL.txt",
),
Ilahi(
  id: 832,
  ciltNo: 1,
  title: "GARİP GÖNLÜM NE HALDESİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/83_2_GARIP_GONLUM_NE_HALDESIN.txt",
),
Ilahi(
  id: 833,
  ciltNo: 1,
  title: "NE GÜZELDİR NE GÜZEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/83_3_NE_GUZELDIR_NE_GUZEL.txt",
),
Ilahi(
  id: 834,
  ciltNo: 1,
  title: "AŞIK OLANLARIN DERDİ TÜKENMEZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/83_4_ASIK_OLANLARIN_DERDI_TUKENMEZ.txt",
),
Ilahi(
  id: 835,
  ciltNo: 1,
  title: "AYLAR BİTER GÜNLER BİTER DERT BİTMEZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/83_5_AYLAR_BITER_GUNLER_BITER_DERT_BITMEZ.txt",
),
Ilahi(
  id: 836,
  ciltNo: 1,
  title: "SÖYLESEM OLMUYOR SUSSAM OLMUYOR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/83_6_SOYLESEM_OLMUYOR_SUSSAM_OLMUYOR.txt",
),
Ilahi(
  id: 83,
  ciltNo: 1,
  title: "EY GÖNÜL DOSTLARI SEFA GELDİNİZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/83_EY_GONUL_DOSTLARI_SEFA_GELDINIZ.txt",
),
Ilahi(
  id: 84,
  ciltNo: 1,
  title: "BEN DERDİMİ YARADANA YANAYIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/84_BEN_DERDIMI_YARADANA_YANAYIM.txt",
),
Ilahi(
  id: 85,
  ciltNo: 1,
  title: "SEN BİZİ NE SANDIN BİZİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/85_SEN_BIZI_NE_SANDIN_BIZI.txt",
),
Ilahi(
  id: 86,
  ciltNo: 1,
  title: "DEMHANEMİZ GÖNÜLDEDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/86_DEMHANEMIZ_GONULDEDIR.txt",
),
Ilahi(
  id: 87,
  ciltNo: 1,
  title: "SAKİ SENİN PAYINDA VAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/87_SAKI_SENIN_PAYINDA_VAR.txt",
),
Ilahi(
  id: 88,
  ciltNo: 1,
  title: "GİDERİZ MEVLAYA ALLAH DİYEREK",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/88_GIDERIZ_MEVLAYA_ALLAH_DIYEREK.txt",
),
Ilahi(
  id: 89,
  ciltNo: 1,
  title: "GÖNLÜNÜ BİL GÖNLÜNÜ BİL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/89_GONLUNU_BIL_GONLUNU_BIL.txt",
),
Ilahi(
  id: 90,
  ciltNo: 1,
  title: "BENİM GÖNLÜM POSTTA DEĞİL DOSTTADIR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/90_BENIM_GONLUM_POSTTA_DEGIL_DOSTTADIR.txt",
),
Ilahi(
  id: 901,
  ciltNo: 1,
  title: "BURA BÜLBÜL YERİ BURA GÜL YERİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/90_BURA_BULBUL_YERI_BURA_GUL_YERI.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=M_jF55jbncA&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF"
),
Ilahi(
  id: 91,
  ciltNo: 1,
  title: "BÜLBÜLÜ BİLMİYOR GÜLÜ BİLMİYOR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/91_BULBULU_BILMIYOR_GULU_BILMIYOR.txt",
),
Ilahi(
  id: 92,
  ciltNo: 1,
  title: "DİLİN SÜKUT ETSİN KALBİN SÖYLESİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/92_DILIN_SUKUT_ETSIN_KALBIN_SOYLESIN.txt",
),
Ilahi(
  id: 93,
  ciltNo: 1,
  title: "SEN GÜL OL DA BÜLBÜLÜNÜ UNUTMA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/93_SEN_GUL_OL_DA_BULBULUNU_UNUTMA.txt",
  youtubeUrl:"https://www.youtube.com/watch?v=2YdnC33-5IQ&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=3" 
),
Ilahi(
  id: 94,
  ciltNo: 1,
  title: "BANA GÖNÜL GEREK BANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/94_BANA_GONUL_GEREK_BANA.txt",
),
Ilahi(
  id: 95,
  ciltNo: 1,
  title: "HANİ GÖNÜL EHLİ HANİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/95_HANI_GONUL_EHLI_HANI.txt",
),
Ilahi(
  id: 96,
  ciltNo: 1,
  title: "BİZ GÖNÜLDEN BERABERİZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/96_BIZ_GONULDEN_BERABERIZ.txt",
),
Ilahi(
  id: 97,
  ciltNo: 1,
  title: "AYIK OL GÖNLÜM AYIK OL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/97_AYIK_OL_GONLUM_AYIK_OL.txt",
),
Ilahi(
  id: 98,
  ciltNo: 1,
  title: "ALAN GELSİN BU MEYDANA SATAN GELSİN BU MEYDANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/98_ALAN_GELSIN_BU_MEYDANA_SATAN_GELSIN_BU_MEYDANA.txt",
),
Ilahi(
  id: 99,
  ciltNo: 1,
  title: "ARININ KADRİNİ BAL OLAN BİLİR BÜLBÜLÜN KADRİNİ GÜL OLAN BİLİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/99_ARININ_KADRINI_BAL_OLAN_BILIR_BULBULUN_KADRINI_GUL_OLAN_BILIR.txt",
),
Ilahi(
  id: 100,
  ciltNo: 1,
  title: "BAŞIMA GELMEDİK HALLER KALMADI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/100_BASIMA_GELMEDIK_HALLER_KALMADI.txt",
),
Ilahi(
  id: 101,
  ciltNo: 1,
  title: "GÖNLÜNÜ BİLMEZDEN BİZE NE FAYDA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/101_GONLUNU_BILMEZDEN_BIZE_NE_FAYDA.txt",
),
Ilahi(
  id: 102,
  ciltNo: 1,
  title: "BENİ BENDE SANMAN BENİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/102_BENI_BENDE_SANMAN_BENI.txt",
),
Ilahi(
  id: 103,
  ciltNo: 1,
  title: "HAKKA GİDEN GÖÇ BİZİMDİR GÖNÜLDEKİ HAC BİZİMDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/103_HAKKA_GIDEN_GOC_BIZIMDIR_GONULDEKI_HAC_BIZIMDIR.txt",
),
Ilahi(
  id: 104,
  ciltNo: 1,
  title: "HAK SÖYLEYEN DİL BİZİMDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/104_HAK_SOYLEYEN_DIL_BIZIMDIR.txt",
),
Ilahi(
  id: 105,
  ciltNo: 1,
  title: "BEN YOLUMU BULDUM YARE GÖNÜLDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/105_BEN_YOLUMU_BULDUM_YARE_GONULDE.txt",
),
Ilahi(
  id: 106,
  ciltNo: 1,
  title: "AŞK İSEN MEYDANA GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/106_ASK_ISEN_MEYDANA_GEL.txt",
),
Ilahi(
  id: 107,
  ciltNo: 1,
  title: "BEN DERDİMİ YARADANA YANAYIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/107_BEN_DERDIMI_YARADANA_YANAYIM.txt",
),
Ilahi(
  id: 108,
  ciltNo: 1,
  title: "SEN BİZİ NE SANDIN BİZİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/108_SEN_BIZI_NE_SANDIN_BIZI.txt",
),
Ilahi(
  id: 109,
  ciltNo: 1,
  title: "DEMHANEMİZ GÖNÜLDEDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/109_DEMHANEMIZ_GONULDEDIR.txt",
),
Ilahi(
  id: 110,
  ciltNo: 1,
  title: "SAKİ SENİN PAYINDA VAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/110_SAKI_SENIN_PAYINDA_VAR.txt",
),
Ilahi(
  id: 111,
  ciltNo: 1,
  title: "GİDERİZ MEVLAYA ALLAH DİYEREK",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/111_GIDERIZ_MEVLAYA_ALLAH_DIYEREK.txt",
),
Ilahi(
  id: 112,
  ciltNo: 1,
  title: "GÖNLÜNÜ BİL GÖNLÜNÜ BİL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/112_GONLUNU_BIL_GONLUNU_BIL.txt",
),
Ilahi(
  id: 113,
  ciltNo: 1,
  title: "BURA BÜLBÜL YERİ BURA GÜL YERİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/113_BURA_BULBUL_YERI_BURA_GUL_YERI.txt",
),
Ilahi(
  id: 114,
  ciltNo: 1,
  title: "NOLA BENİM HALİM NOLA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/114_NOLA_BENIM_HALIM_NOLA.txt",
),
Ilahi(
  id: 115,
  ciltNo: 1,
  title: "EL KİTAPTAN BEN GÖNÜLDEN OKURUM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/115_EL_KITAPTAN_BEN_GONULDEN_OKURUM.txt",
),
Ilahi(
  id: 116,
  ciltNo: 1,
  title: "BUGÜN BERAAT GÜNÜ BUGÜN AF GÜNÜ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/116_BUGUN_BERAAT_GUNU_BUGUN_AF_GUNU.txt",
),
Ilahi(
  id: 117,
  ciltNo: 1,
  title: "GAFİL MİDİR CAHİL MİDİR BU ELLER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/117_GAFIL_MIDIR_CAHIL_MIDIR_BU_ELLER.txt",
),
Ilahi(
  id: 118,
  ciltNo: 1,
  title: "ELVEDA KARDEŞLER BEN GİDER OLDUM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/118_ELVEDA_KARDESLER_BEN_GIDER_OLDUM.txt",
),
Ilahi(
  id: 119,
  ciltNo: 1,
  title: "ALLAH CELLADIR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/119_ALLAH_CELLADIR.txt",
),
Ilahi(
  id: 120,
  ciltNo: 1,
  title: "KARAR VER GÖNÜLDEN HAKKA GİDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/120_KARAR_VER_GONULDEN_HAKKA_GIDELIM.txt",
),
Ilahi(
  id: 121,
  ciltNo: 1,
  title: "İNANIP ALLAH ALLAH DE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/121_INANIP_ALLAH_ALLAH_DE.txt",
),
Ilahi(
  id: 122,
  ciltNo: 1,
  title: "MUHAMMEDİM MUHAMMEDİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/122_MUHAMMEDIM_MUHAMMEDIM.txt",
),
Ilahi(
  id: 123,
  ciltNo: 1,
  title: "MUHAMMEDE MUHAMMEDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/123_MUHAMMEDE_MUHAMMEDE.txt",
),
Ilahi(
  id: 124,
  ciltNo: 1,
  title: "CAN AHMEDİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/124_CAN_AHMEDIM.txt",
),
Ilahi(
  id: 125,
  ciltNo: 1,
  title: "BENİ AL GÖNLÜNE BENİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/125_BENI_AL_GONLUNE_BENI.txt",
),
Ilahi(
  id: 126,
  ciltNo: 1,
  title: "DERVİŞLERİN GÖNLÜ PİRSİZ EĞLENMEZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/126_DERVISLERIN_GONLU_PIRSIZ_EGLENMEZ.txt",
),
Ilahi(
  id: 127,
  ciltNo: 1,
  title: "BU AŞKIN DERDİNİ ÇEKENLERE SOR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/127_BU_ASKIN_DERDINI_CEKENLERE_SOR.txt",
),
Ilahi(
  id: 128,
  ciltNo: 1,
  title: "AŞK DERDİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/128_ASK_DERDI.txt",
),
Ilahi(
  id: 129,
  ciltNo: 1,
  title: "HACILARIN GÖNLÜ GEZER HİCAZDA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/129_HACILARIN_GONLU_GEZER_HICAZDA.txt",
),
Ilahi(
  id: 130,
  ciltNo: 1,
  title: "DERVİŞİN BAYRAMI PİR İLE OLUR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/130_DERVISIN_BAYRAMI_PIR_ILE_OLUR.txt",
),
Ilahi(
  id: 131,
  ciltNo: 1,
  title: "MABUD ALLAH MAKSUD ALLAH",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/131_MABUD_ALLAH_MAKSUD_ALLAH.txt",
),
Ilahi(
  id: 132,
  ciltNo: 1,
  title: "MECNUN DERDİNİ LEYLAYA SORUN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/132_MECNUN_DERDINI_LEYLAYA_SORUN.txt",
),
Ilahi(
  id: 133,
  ciltNo: 1,
  title: "AŞKI KOYMUŞ GÖNLÜMÜZE YARADAN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/133_ASKI_KOYMUS_GONLUMUZE_YARADAN.txt",
),
Ilahi(
  id: 134,
  ciltNo: 1,
  title: "AŞKIN KAHRI ÇETİN ÇEKECEK MİSİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/134_ASKIN_KAHRI_CETIN_CEKECEK_MISIN.txt",
),
Ilahi(
  id: 135,
  ciltNo: 1,
  title: "GÖNÜL NE DURURSUN SEN GARİP GARİP",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/135_GONUL_NE_DURURSUN_SEN_GARIP_GARIP.txt",
),
Ilahi(
  id: 136,
  ciltNo: 1,
  title: "GELİN ALLAH İÇİN BİR DEM ÇEKELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/136_GELIN_ALLAH_ICIN_BIR_DEM_CEKELIM.txt",
),
Ilahi(
  id: 137,
  ciltNo: 1,
  title: "BİR AŞIĞIN GÖNLÜNE GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/137_BIR_ASIGIN_GONLUNE_GEL.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=ZWXsjpQQ3y4&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=5"
),
Ilahi(
  id: 138,
  ciltNo: 1,
  title: "OTUR HUZUR İLE DUR HUZUR İLE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/138_OTUR_HUZUR_ILE_DUR_HUZUR_ILE.txt",
),
Ilahi(
  id: 139,
  ciltNo: 1,
  title: "DİLLER İLHAM SÖYLETİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/139_DILLER_ILHAM_SOYLETIR.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=z5x01i_9yuI&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=7"
),
Ilahi(
  id: 140,
  ciltNo: 1,
  title: "GÖNÜL UYUMAZ UYUMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/140_GONUL_UYUMAZ_UYUMAZ.txt",
),
Ilahi(
  id: 141,
  ciltNo: 1,
  title: "YANAR AŞKTAN ÖZÜM AĞLAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/141_YANAR_ASKTAN_OZUM_AGLAR.txt",
),
Ilahi(
  id: 142,
  ciltNo: 1,
  title: "BEN SÖYLEYİM SİZ DİNLEYİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/142_BEN_SOYLEYIM_SIZ_DINLEYIN.txt",
),
Ilahi(
  id: 143,
  ciltNo: 1,
  title: "UNUTULMAZ UNUTULMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
 lyricsPath: "assets/text/143_UNUTULMAZ_UNUTULMAZ.txt",
),
Ilahi(
  id: 144,
  ciltNo: 1,
  title: "SIRININ GEZDİĞİ BAĞLARI GÖRDÜM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/144_SIRININ_GEZDIGI_BAGLARI_GORDUM.txt",
),
Ilahi(
  id: 145,
  ciltNo: 1,
  title: "İÇECEKSİN BU DEMDEN BU DEMDEN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/145_ICECEKSIN_BU_DEMDEN_BU_DEMDEN.txt",
  
),
Ilahi(
  id: 146,
  ciltNo: 1,
  title: "İÇECEKSİN SEN BU DEMDEN BU DEMDEN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/146_ICECEKSIN_SEN_BU_DEMDEN_BU_DEMDEN.txt",
),
Ilahi(
  id: 147,
  ciltNo: 1,
  title: "YA BEN NİDEM MEVLA NİDEM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/147_YA_BEN_NIDEM_MEVLA_NIDEM.txt",
),
Ilahi(
  id: 148,
  ciltNo: 1,
  title: "SENİN AŞKIN İLE SENİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/148_SENIN_ASKIN_ILE_SENIN.txt",
),
Ilahi(
  id: 149,
  ciltNo: 1,
  title: "GÖNÜL SANA DEDEDİM Mİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/149_GONUL_SANA_DEMEDIM_MI.txt",
),
Ilahi(
  id: 150,
  ciltNo: 1,
  title: "HAKİKAT CEVHERİN ALANLAR GELSİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/150_HAKIKAT_CEVHERIN_ALANLAR_GELSIN.txt",
),
Ilahi(
  id: 151,
  ciltNo: 1,
  title: "BİZE KUL DEMEZLER YA NE DERLER YA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/151_BIZE_KUL_DEMEZLER_YA_NE_DERLER_YA.txt",
),
Ilahi(
  id: 152,
  ciltNo: 1,
  title: "HAKKA PAZARIMIZ GÖNÜL DEĞİL Mİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/152_HAKKKA_PAZARIMIZ_GONUL_DEGIL_MI.txt",
),
Ilahi(
  id: 153,
  ciltNo: 1,
  title: "SANA GELECEĞİM SANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/153_SANA_GELECEGIM_SANA.txt",
),
Ilahi(
  id: 154,
  ciltNo: 1,
  title: "BİZİ ARAYANLAR GÖNÜLDE BULSUN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/154_BIZI_ARAYANLAR_GONULDE_BULSUN.txt",
),
Ilahi(
  id: 155,
  ciltNo: 1,
  title: "GİDELİM GÖNÜL GİDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/155_GIDELIM_GONUL_GIDELIM.txt",
),
Ilahi(
  id: 156,
  ciltNo: 1,
  title: "BEN YOK OLSAM DA SEN VAR OL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/156_BEN_YOK_OLSAM_DA_SEN_VAR_OL.txt",
),
Ilahi(
  id: 157,
  ciltNo: 1,
  title: "AYIK OL LAYIK OL HAKKA GİDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/157_AYIK_OL_LAYIK_OL_HAKKKA_GIDELIM.txt",
),
Ilahi(
  id: 158,
  ciltNo: 1,
  title: "HALİS OLAN İHLAS EHLİ KUL OLUR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/158_HALIS_OLAN_IHLAS_EHLI_KUL_OLUR.txt",
),
Ilahi(
  id: 159,
  ciltNo: 1,
  title: "GÖNÜLDE HALLER VAR İNCEDEN İNCE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/159_GONULDE_HALLER_VAR_INCEDEN_INCE.txt",
),
Ilahi(
  id: 160,
  ciltNo: 1,
  title: "AŞIK OLAN GÖNÜLLERE KONUŞUR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/160_ASIK_OLAN_GONULLERE_KONUSUR.txt",
),
Ilahi(
  id: 161,
  ciltNo: 1,
  title: "SANA BİR HAL OLDU GÖNLÜM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/161_SANA_BIR_HAL_OLDU_GONLUM.txt",
),
Ilahi(
  id: 162,
  ciltNo: 1,
  title: "KALBİNDE ALLAH ALLAH DE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/162_KALBINDE_ALLAH_ALLAH_DE.txt",
),
Ilahi(
  id: 163,
  ciltNo: 1,
  title: "BEN ALLAH DEMEYİM YA NE DEYİM YA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/163_BEN_ALLAH_DEMEYIM_YA_NE_DEYIM_YA.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=coOUpdE3uKA&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=22"
),
Ilahi(
  id: 164,
  ciltNo: 1,
  title: "SADIK OLMAYANDAN BİZE NE FAYDA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/164_SADIK_OLMAYANDAN_BIZE_NE_FAYDA.txt",
),
Ilahi(
  id: 165,
  ciltNo: 1,
  title: "SAKLA GÖNLÜNE GÖNLÜNE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/165_SAKLA_GONLUNE_GONLUNE.txt",
),
Ilahi(
  id: 166,
  ciltNo: 1,
  title: "HUZUR GÖNÜLDE SEN NEREDESİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/166_HUZUR_GONULDE_SEN_NEREDESIN.txt",
),
Ilahi(
  id: 167,
  ciltNo: 1,
  title: "BU LEYLEİ KADİRDİR BU",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/167_BU_LEYLEI_KADIRDIR_BU.txt",
),
Ilahi(
  id: 168,
  ciltNo: 1,
  title: "AŞIĞI KADİRDE UYUR MU SANDIN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/168_ASIGI_KADIRDE_UYUR_MU_SANDIN.txt",
),
Ilahi(
  id: 169,
  ciltNo: 1,
  title: "SİZDE YANICAK DERT BULUNMAZ MI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/169_SIZDE_YANILACAK_DERT_BULUNMAZ_MI.txt",
),
Ilahi(
  id: 170,
  ciltNo: 1,
  title: "GÖNÜL AYNASINI SİL DE BERİ GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/170_GONUL_AYNASINI_SIL_DE_BERI_GEL.txt",
),
Ilahi(
  id: 171,
  ciltNo: 1,
  title: "BİZİM GÖNÜLLERDEN HABERİMİZ VAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/171_BIZIM_GONULLERDEN_HABERIMIZ_VAR.txt",
),
Ilahi(
  id: 172,
  ciltNo: 1,
  title: "GÖNLÜ BİLMEYENLER BİZİ NE BİLSİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/172_GONLU_BILMEYENLER_BIZI_NE_BILSIN.txt",
),
Ilahi(
  id: 173,
  ciltNo: 1,
  title: "SADIK OL GÖNLÜNÜ YD ELE VERME",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/173_SADIK_OL_GONLUNU_YD_ELE_VERME.txt",
),
Ilahi(
  id: 174,
  ciltNo: 1,
  title: "KALBİM UYUR GÖNLÜM UYUR GÖZ UYUR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/174_KALBIM_UYUR_GONLUM_UYUR_GOZ_UYUR.txt",
),
Ilahi(
  id: 175,
  ciltNo: 1,
  title: "GELİN KALBİN AYNASINI SİLELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/175_GELIN_KALBIN_AYNASINI_SILELIM.txt",
),
Ilahi(
  id: 176,
  ciltNo: 1,
  title: "BEN BÜLBÜLÜ SEYDAYIM BEN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/176_BEN_BULBULU_SEYDAYIM_BEN.txt",
),
Ilahi(
  id: 177,
  ciltNo: 1,
  title: "BÜLBÜLÜN DİLİNDE ZAR EKSİK OLMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/177_BULBULUN_DILINDE_ZAR_EKSIK_OLMAZ.txt",
),
Ilahi(
  id: 178,
  ciltNo: 1,
  title: "AŞK CEVHERİN BULSAN NOLUR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/178_ASK_CEVHERIN_BULSAN_NOLUR.txt",
),
Ilahi(
  id: 179,
  ciltNo: 1,
  title: "SANA MAHMUDİYE SANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/179_SANA_MAHMUDIYE_SANA.txt",
),
Ilahi(
  id: 180,
  ciltNo: 1,
  title: "SENDE BABA KOYU SENDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/180_SENDE_BABA_KOYU_SENDE.txt",
),
Ilahi(
  id: 181,
  ciltNo: 1,
  title: "BENİ BANA KOYMA BENİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/181_BENI_BANA_KOYMA_BENI.txt",
),
Ilahi(
  id: 182,
  ciltNo: 1,
  title: "SELAMIMİZI ALIP GÖTÜR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/182_SELAMIMIZI_ALIP_GOTUR.txt",
),
Ilahi(
  id: 183,
  ciltNo: 1,
  title: "ALANLARA SELAM OLSUN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/183_ALANLARA_SELAM_OLSUN.txt",
),
Ilahi(
  id: 184,
  ciltNo: 1,
  title: "GÖNÜL EĞLENMEZİ EĞLENMEZİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/184_GONUL_EGLENMEZ_EGLENMEZ.txt",
),
Ilahi(
  id: 185,
  ciltNo: 1,
  title: "AYIK OL LAYIK OL HAKTAN AYRILMA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text/185_AYIK_OL_LAYIK_OL_HAKKTAN_AYRILMA.txt",
),

//ikinci cilde geçiyoruz ama 1de eksikler var sayfa 261 de kaldık
Ilahi(
  id: 1,
  ciltNo: 2,
  title: "KULUN DERDİNİ MEVLAYA SORUN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/1_KULUN_DERDINI_MEVLAYA_SORUN.txt",
),
Ilahi(
  id: 2,
  ciltNo: 2,
  title: "BEN AĞLAYIM SİZ AĞLAYIN HAK İÇİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/2_BEN_AGLAYIM_SIZ_AGLAYIN_HAK_ICIN.txt",
),
Ilahi(
  id: 3,
  ciltNo: 2,
  title: "İSTEDİĞİM HAKTIR BENİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/3_ISTEDIGIM_HAKTIR_BENIM.txt",
),
Ilahi(
  id: 4,
  ciltNo: 2,
  title: "AŞIK OLAN KADİR BERAT BEKLEMEZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/4_ASIK_OLAN_KADIR_BERAT_BEKLEMEZ.txt",
),
Ilahi(
  id: 5,
  ciltNo: 2,
  title: "AYIK OL GÖNLÜNÜ YAD ELE VERME",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/5_AYIK_OL_GONLUNU_YAD_ELE_VERME.txt",
),
Ilahi(
  id: 6,
  ciltNo: 2,
  title: "BANA GÖNÜL DERDİ DÜŞTÜ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/6_BANA_GONUL_DERDI_DUSTU.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=ytu9vfuQhd4&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=16"
),
Ilahi(
  id: 7,
  ciltNo: 2,
  title: "SEN GÜL OL DA BÜLBÜLÜNÜ UNUTMA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/7_SEN_GUL_OL_DA_BULBULUNU_UNUTMA.txt",
),
Ilahi(
  id: 8,
  ciltNo: 2,
  title: "BENİ KULLARINA BİLEN BİLDİRSİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/8_BENI_KULLARINA_BILEN_BILDIRSIN.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=V1X0FWCJlvo&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=9"
),
Ilahi(
  id: 9,
  ciltNo: 2,
  title: "BU SENİN GÖNLÜNE NE OLDU SENİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/9_BU_SENIN_GONLUNE_NE_OLDU_SENIN.txt",
),
Ilahi(
  id: 10,
  ciltNo: 2,
  title: "HABER VER GÖNLÜNE HAKKA GİDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/10_HABER_VER_GONLUNE_HAKKA_GIDELIM.txt",
),
Ilahi(
  id: 11,
  ciltNo: 2,
  title: "BİZİM GÖNÜLLERE NAZARIMIZ VAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/11_BIZIM_GONULLERE_NAZARIMIZ_VAR.txt",
),
Ilahi(
  id: 12,
  ciltNo: 2,
  title: "ALEMDE GÜNAHKAR BEN BENİ BULDUM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/12_ALEMDE_GUNAHKAR_BEN_BENI_BULDUM.txt",
),
Ilahi(
  id: 13,
  ciltNo: 2,
  title: "ARININ KADRİNİ BAL OLAN BİLİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/13_ARININ_KADRINI_BAL_OLAN_BILIR.txt",
),
Ilahi(
  id: 14,
  ciltNo: 2,
  title: "AYIK OL GÖNLÜNÜ YAD ELE VERME",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/14_AYIK_OL_GONLUNU_YAD_ELE_VERME.txt",
),
Ilahi(
  id: 15,
  ciltNo: 2,
  title: "BANA GÖNÜL DERDİ DÜŞTÜ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/15_BANA_GONUL_DERDI_DUSTU.txt",
),
Ilahi(
  id: 16,
  ciltNo: 2,
  title: "SEN GÜL OL DA BÜLBÜLÜNÜ UNUTMA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/16_SEN_GUL_OL_DA_BULBULUNU_UNUTMA.txt",
),
Ilahi(
  id: 17,
  ciltNo: 2,
  title: "BENİ KULLARINA BİLEN BİLDİRSİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/17_BENI_KULLARINA_BILEN_BILDIRSIN.txt",
),
Ilahi(
  id: 18,
  ciltNo: 2,
  title: "AŞKA TALİP İKİ GÖNÜL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/18_ASKA_TALIP_IKI_GONUL.txt",
),
Ilahi(
  id: 19,
  ciltNo: 2,
  title: "BABAKÖYÜ BÜLBÜLLERİN NEREDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/19_BABAKOYU_BULBULLERIN_NEREDE.txt",
),
Ilahi(
  id: 20,
  ciltNo: 2,
  title: "HANİ SİZİN AŞKLI GÖNLÜNÜZ HANİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/20_HANI_SIZIN_ASKLI_GONLUNUZ_HANI.txt",
),
Ilahi(
  id: 21,
  ciltNo: 2,
  title: "EL UYURDA BENİM GÖNLÜM UYUMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/21_EL_UYURDA_BENIM_GONLUM_UYUMAZ.txt",
),
Ilahi(
  id: 22,
  ciltNo: 2,
  title: "AĞLASANA NE DURURSUN GÖZLERİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/22_AGLASANA_NE_DURURSUN_GOZLERIM.txt",
),
Ilahi(
  id: 23,
  ciltNo: 2,
  title: "BU GÖNÜLHANEYE SEFA GELDİNİZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/23_BU_GONULHANEYE_SEFA_GELDINIZ.txt",
),
Ilahi(
  id: 24,
  ciltNo: 2,
  title: "GAFİL GÖNÜL SENLE KANDİL KUTLANMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/24_GAFIL_GONUL_SENLE_KANDIL_KUTLANMAZ.txt",
),
Ilahi(
  id: 25,
  ciltNo: 2,
  title: "VAR MI GÖNÜL EHLİ VAR MI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/25_VARMI_GONUL_EHLI_VARMI.txt",
),
Ilahi(
  id: 26,
  ciltNo: 2,
  title: "BENİM BU YANDIĞIM GÖNÜL DERDİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/26_BENIM_BU_YANDIGIM_GONUL_DERDI.txt",
),
Ilahi(
  id: 27,
  ciltNo: 2,
  title: "GÖNÜL EHLİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/27_GONUL_EHLI.txt",
),
Ilahi(
  id: 28,
  ciltNo: 2,
  title: "BİLMEM Kİ SEN NESİN GÖNÜL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/28_BILMEMKI_SEN_NESIN_GONUL.txt",
),
Ilahi(
  id: 29,
  ciltNo: 2,
  title: "HERGÜN BULUNURDA BUGÜN BULUNMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/29_HERGUN_BULUNURDA_BUGUN_BULUNMAZ.txt",
),
Ilahi(
  id: 30,
  ciltNo: 2,
  title: "KALBİNE SOR GÖNLÜNE SOR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/30_KALBINE_SOR_GONLUNE_SOR.txt",
),
Ilahi(
  id: 31,
  ciltNo: 2,
  title: "AYIK OL HUZURA GETİR GÖNLÜNÜ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/31_AYIK_OL_HUZURA_GETIR_GONLUNU.txt",
),
Ilahi(
  id: 32,
  ciltNo: 2,
  title: "RABBİM BU DERGAHA BİR NAZAR EYLE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/32_RABBIM_BU_DERGAHA_BIR_NAZAR_EYLE.txt",
),
Ilahi(
  id: 33,
  ciltNo: 2,
  title: "BUGÜN BU DERGAHA BİR BÜLBÜL GELDİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/33_BUGUN_BU_DERGAHA_BIR_BULBUL_GELDI.txt",
),
Ilahi(
  id: 330,
  ciltNo: 2,
  title: "KARADA HOŞ BEYAZDA HOŞ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/33_KARADA_HOS_BEYAZDA_HOS.txt",
),
Ilahi(
  id: 34,
  ciltNo: 2,
  title: "BEN NE DİYEM NE SÖYLEYEM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/34_BEN_NE_DIYEM_NE_SOYLEYEM.txt",
),
Ilahi(
  id: 35,
  ciltNo: 2,
  title: "SAKLA GÖNLÜNE GÖNLÜNE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/35_SAKLA_GONLUNE_GONLUNE.txt",
),
Ilahi(
  id: 36,
  ciltNo: 2,
  title: "BU DEMDE AĞLARLA İRŞADIMIZ VAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/36_BU_DEMDE_AGLARLA_IRSADIMIZ_VAR.txt",
),
Ilahi(
  id: 37,
  ciltNo: 2,
  title: "AYIK OL GÖNÜLDEN HUZURU BOZMA LAYIK OL GÖNÜLDEN HUZURU BOZMA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/37_AYIK_OL_GONULDEN_HUZURU_BOZMA_LAYIK_OL_GONULDEN_HUZURU_BOZMA.txt",
),
Ilahi(
  id: 38,
  ciltNo: 2,
  title: "BEN AĞLAYAM SİZ AĞLAYIN HAK İÇİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/38_BEN_AGLAYAM_SIZ_AGLAYIN_HAK_ICIN.txt",
),
Ilahi(
  id: 39,
  ciltNo: 2,
  title: "BUGÜN BERAT GÜNÜ BUGÜN AF GÜNÜ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/39_BUGUN_BERAT_GUNU_BUGUN_AF_GUNU.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=sU1uRIR8PTM&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=8"
),
Ilahi(
  id: 40,
  ciltNo: 2,
  title: "KUL İNCİNMESİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/40_KUL_INCINMESIN.txt",
),
Ilahi(
  id: 41,
  ciltNo: 2,
  title: "MAHRUM EYLEME",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/41_MAHRUM_EYLEME.txt",
),
Ilahi(
  id: 42,
  ciltNo: 2,
  title: "BİZE LÜTF EYLE ALLAHIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/42_BIZE_LUTF_EYLE_ALLAHIM.txt",
),
Ilahi(
  id: 43,
  ciltNo: 2,
  title: "BUGÜN AŞIKLARIN BAYRAMI BUGÜN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/43_BUGUN_ASIKLARIN_BAYRAMI_BUGUN.txt",
),
Ilahi(
  id: 44,
  ciltNo: 2,
  title: "GELEN GELSİN KALAN KALSIN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/44_GELEN_GELSIN_KALAN_KALSIN.txt",
),
Ilahi(
  id: 45,
  ciltNo: 2,
  title: "UYAN GAFİL UYAN ÖLÜM VAR ÖLÜM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/45_UYAN_GAFIL_UYAN_OLUM_VAR_OLUM.txt",
),
Ilahi(
  id: 46,
  ciltNo: 2,
  title: "SABIR EYLE HUZURUMUZ BOZMADAN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/46_SABIR_EYLE_HUZURUMUZ_BOZMADAN.txt",
),
Ilahi(
  id: 48,
  ciltNo: 2,
  title: "BANA AŞKIN YETER BANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/48_BANA_ASKIN_YETER_BANA.txt",
),
Ilahi(
  id: 49,
  ciltNo: 2,
  title: "HAKKI ZİKRETMEYEN DİL NEYE YARAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/49_HAKKI_ZIKRETMEYEN_DIL_NEYE_YARAR.txt",
),
Ilahi(
  id: 50,
  ciltNo: 2,
  title: "SABIR EYLE HUZURUMUZ BOZMADAN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/50_SABIR_EYLE_HUZURUMUZ_BOZMADAN.txt",
),
Ilahi(
  id: 51,
  ciltNo: 2,
  title: "GÖNÜL YOLLARINA DELİL EVLİYA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/51_GONUL_YOLLARINA_DELIL_EVLIYA.txt",
),
Ilahi(
  id: 52,
  ciltNo: 2,
  title: "BANA AŞKIN YETER BANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/52_BANA_ASKIN_YETER_BANA.txt",
),
Ilahi(
  id: 53,
  ciltNo: 2,
  title: "HAKKI ZİKRETMEYEN DİL NEYE YARAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/53_HAKKI_ZIKRETMEYEN_DIL_NEYE_YARAR.txt",
),
Ilahi(
  id: 54,
  ciltNo: 2,
  title: "KULUNA MEVLADAN İLHAM DİLEYE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/517_KULUNA_MEVLADAN_ILHAM_DILEYE.txt",
),
Ilahi(
  id: 55,
  ciltNo: 2,
  title: "UYAN GAFİL UYAN HAKKA GİDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/519_UYAN_GAFIL_UYAN_HAKKA_GIDELIM.txt",
),
Ilahi(
  id: 56,
  ciltNo: 2,
  title: "SENDE BÜLBÜL OLACAKSIN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/521_SENDE_BULBUL_OLACAKSIN.txt",
),
Ilahi(
  id: 57,
  ciltNo: 2,
  title: "ALLAH DE KALBİM ALLAH DE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/523_ALLAH_DE_KALBIM_ALLAH_DE.txt",
),
Ilahi(
  id: 58,
  ciltNo: 2,
  title: "OLUR OLUR OLUR YA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/525_OLUR_OLUR_OLUR_YA.txt",
),
Ilahi(
  id: 59,
  ciltNo: 2,
  title: "BİZE BÜLBÜL DERLER BÜLBÜL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/527_BIZE_BULBUL_DERLER_BULBUL.txt",
),
Ilahi(
  id: 60,
  ciltNo: 2,
  title: "MEVLA SENDEN HOŞNUT OLSUN İBRAHİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/529_MEVLA_SENDEN_HOSNUT_OLSUN_IBRAHIM.txt",
),
Ilahi(
  id: 61,
  ciltNo: 2,
  title: "BUGÜN BÜLBÜLLERİN ÖTME GÜNÜDÜR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/531_BUGUN_BULBULLERIN_OTME_GUNUDUR.txt",
),
Ilahi(
  id: 62,
  ciltNo: 2,
  title: "SEN ALLAH DİYORSAN BENDE EFENDİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/533_SEN_ALLAH_DIYORSAN_BENDE_EFENDIM.txt",
),
Ilahi(
  id: 63,
  ciltNo: 2,
  title: "GAFLETTE KALMANIN ZAMANI DEĞİL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/535_GAFLETTE_KALMANIN_ZAMANI_DEGIL.txt",
),
Ilahi(
  id: 64,
  ciltNo: 2,
  title: "ACİZ GÖNLÜM SAKIN HAKTAN AYRILMA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/537_ACIZ_GONLUM_SAKIN_HAKTAN_AYRILMA.txt",
),
Ilahi(
  id: 65,
  ciltNo: 2,
  title: "GERÇEK AŞIK OLSAK AŞIK",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/539_GERCEK_ASIK_OLSAK_ASIK.txt",
),
Ilahi(
  id: 66,
  ciltNo: 2,
  title: "UYUMA GÖZLERİM BERAT UMSANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/542_UYUMA_GOZLERIM_BERAT_UMSANA.txt",
),
Ilahi(
  id: 67,
  ciltNo: 2,
  title: "SANA AL GÖNLÜMÜ SANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/544_SANA_AL_GONLUMU_SANA.txt",
),
Ilahi(
  id: 68,
  ciltNo: 2,
  title: "SENİ SÖYLETİRLER SENİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/546_SENI_SOYLETIRLER_SENI.txt",
),
Ilahi(
  id: 69,
  ciltNo: 2,
  title: "BİRAZDA AŞIĞA AŞKA YOL VERİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/548_BIRAZDA_ASIGA_ASKA_YOL_VERIN.txt",
),
Ilahi(
  id: 70,
  ciltNo: 2,
  title: "BEN GÖNLÜMÜ EFENDİME BAĞLADIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/550_BEN_GONLUMU_EFENDIME_BAGLADIM.txt",
),
Ilahi(
  id: 71,
  ciltNo: 2,
  title: "YAKANI ELİNDEN ALAMAZSIN HA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/552_YAKANI_ELINDEN_ALAMAZSIN_HA.txt",
),
Ilahi(
  id: 72,
  ciltNo: 2,
  title: "HAKKA YALVARSAM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/555_HAKKA_YALVARSAM.txt",
),
Ilahi(
  id: 73,
  ciltNo: 2,
  title: "BİZE AŞIK DERLER BİZE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/557_BIZE_ASIK_DERLER_BIZE.txt",
),
Ilahi(
  id: 74,
  ciltNo: 2,
  title: "SEN O GÖNLE GELECEKSİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/562_SEN_O_GONLE_GELECEKSIN.txt",
),
Ilahi(
  id: 75,
  ciltNo: 2,
  title: "GEL ALLAHA DÖNELİM GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/565_GEL_ALLAHA_DONELIM_GEL.txt",
),
Ilahi(
  id: 76,
  ciltNo: 2,
  title: "SENİN AŞKIN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/567_SENIN_ASKIN.txt",
),
Ilahi(
  id: 77,
  ciltNo: 2,
  title: "BİZİ ANLAMAZ ANLAMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/569_BIZI_ANLAMAZ_ANLAMAZ.txt",
),
Ilahi(
  id: 78,
  ciltNo: 2,
  title: "GÖR BİZİ AŞK NEYLEDİ GÖR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/571_GOR_BIZI_ASK_NEYLEDI_GOR.txt",
),
Ilahi(
  id: 79,
  ciltNo: 2,
  title: "BİLDİM GÖNÜL ALEMİNDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/573_BILDIM_GONUL_ALEMINDE.txt",
),
Ilahi(
  id: 80,
  ciltNo: 2,
  title: "BIRAK BENİ DEMLENEYİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/574_BIRAK_BENI_DEMLENEYIM.txt",
),
Ilahi(
  id: 81,
  ciltNo: 2,
  title: "DİKELİM Mİ DİKELİM Mİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/577_DIKELIM_MI_DIKELIM_MI.txt",
),
Ilahi(
  id: 82,
  ciltNo: 2,
  title: "OTURURUZ ALLAH İÇİN YALVARIRIZ ALLAH İÇİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/579_OTURURUZ_ALLAH_ICIN_YALVARIRIZ_ALLAH_ICIN.txt",
),
Ilahi(
  id: 83,
  ciltNo: 2,
  title: "DOLDUR SAKİ DEMİN DOLDUR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/582_DOLDUR_SAKI_DEMIN_DOLDUR.txt",
),
Ilahi(
  id: 84,
  ciltNo: 2,
  title: "GÖNÜL HAKTA HAK GÖNÜLDE GEZİYOR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/584_GONUL_HAKTA_HAK_GONULDE_GEZIYOR.txt",
),
Ilahi(
  id: 85,
  ciltNo: 2,
  title: "GEL SENİNLE DERT ORTAĞI OLALIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/585_GEL_SENINLE_DERT_ORTAGI_OLALIM.txt",
),
Ilahi(
  id: 86,
  ciltNo: 2,
  title: "ASLIN NERDE SEN NEREDESİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/586_ASLIN_NERDE_SEN_NEREDESIN.txt",
),
Ilahi(
  id: 87,
  ciltNo: 2,
  title: "PİRİMLE DEM BERABER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/587_PIRIMLE_DEM_BERABER.txt",
),
Ilahi(
  id: 88,
  ciltNo: 2,
  title: "NEŞE DEMİ AŞK DEMİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/588_NESE_DEMI_ASK_DEMI.txt",
),
Ilahi(
  id: 89,
  ciltNo: 2,
  title: "HANE SENİN MUHABBETTİN BOL OLSUN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/589_HANE_SENIN_MUHABBETTIN_BOL_OLSUN.txt",
),
Ilahi(
  id: 90,
  ciltNo: 2,
  title: "YAPRAKLAR AĞLADI DALLAR AĞLADI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/590_YAPRAKLAR_AGLADI_DALLAR_AGLADI.txt",
),
Ilahi(
  id: 91,
  ciltNo: 2,
  title: "BİR GÜN SANA GELECEĞİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/591_BIR_GUN_SANA_GELECEGIM.txt",
),
Ilahi(
  id: 92,
  ciltNo: 2,
  title: "GEL EY GÖNÜL HAKKA GİDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/592_GEL_EY_GONUL_HAKKA_GIDELIM.txt",
),
Ilahi(
  id: 93,
  ciltNo: 2,
  title: "CANIM KURBAN OLSUN SANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/593_CANIM_KURBAN_OLSUN_SANA.txt",
),
Ilahi(
  id: 94,
  ciltNo: 2,
  title: "HAK YOLUNDA BİR YOLCUYUM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/594_HAK_YOLUNDA_BIR_YOLCUYUM.txt",
),
Ilahi(
  id: 95,
  ciltNo: 2,
  title: "AĞLA GÖZÜM AĞLA GARİP BASTASIN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/600_AGLA_GOZUM_AGLA_GARIP_BASTASIN.txt",
),
Ilahi(
  id: 96,
  ciltNo: 2,
  title: "BENİM KALBİM YAR ELİNDEN YARALI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/601_BENIM_KALBIM_YAR_ELINDEN_YARALI.txt",
),
Ilahi(
  id: 97,
  ciltNo: 2,
  title: "BENİM DERDİM YARADANDAN YANADIR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/602_BENIM_DERDIM_YARADANDAN_YANADIR.txt",
),
Ilahi(
  id: 98,
  ciltNo: 2,
  title: "GELİN BERABER YANALIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/603_GELIN_BERABER_YANALIM.txt",
),
Ilahi(
  id: 99,
  ciltNo: 2,
  title: "AYRILMA GÖNÜL AYRILMA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/604_AYRILMA_GONUL_AYRILMA.txt",
),
Ilahi(
  id: 100,
  ciltNo: 2,
  title: "YARİN UNUTMA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/605_YARIN_UNUTMA.txt",
),
Ilahi(
  id: 101,
  ciltNo: 2,
  title: "GEL GÖNÜL EVİNE DERTLEŞELİM GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/630_GEL_GONUL_EVINE_DERTLESELIM_GEL.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=1gg55qq0ufM&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=24",
),
Ilahi(
  id: 102,
  ciltNo: 2,
  title: "SADIK OL DA BERİ GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/634_SADIK_OL_DA_BERI_GEL.txt",
),
Ilahi(
  id: 103,
  ciltNo: 2,
  title: "AŞIKLAR YARİNDEN OLUR AYRILMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/636_ASIKLAR_YARINDEN_OLUR_AYRILMAZ.txt",
),
Ilahi(
  id: 104,
  ciltNo: 2,
  title: "BENİM GÖNLÜM BERAT İSTER AF İSTER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/638_BENIM_GONLUM_BERAT_ISTER_AF_ISTER.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=sM0CQST63fo&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=23"
),
Ilahi(
  id: 105,
  ciltNo: 2,
  title: "YARAB BİZİ MUHAMMEDDE BAĞIŞLA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/640_YARAB_BIZI_MUHAMMEDDE_BAGISLA.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=y9cUK7mQBOs&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=19"
),
Ilahi(
  id: 106,
  ciltNo: 2,
  title: "BU DERGAHI NAKŞIDIR BU",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/642_BU_DERGAHI_NAKSIDIR_BU.txt",
),
Ilahi(
  id: 107,
  ciltNo: 2,
  title: "SÖYLE DERVİŞLERDEN BİZE HABER VER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/644_SOYLE_DERVISLERDEN_BIZE_HABER_VER.txt",
),
Ilahi(
  id: 108,
  ciltNo: 2,
  title: "BEN DERMANI YARADANDAN İSTERİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/646_BEN_DERMANI_YARADANDAN_ISTERIM.txt",
),
Ilahi(
  id: 109,
  ciltNo: 2,
  title: "HACILAR KABEDEN SEFA GELDİNİZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/650_HACILAR_KABEDEN_SEFA_GELDINIZ.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=sI14gWw7mP8&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=14"
),
Ilahi(
  id: 110,
  ciltNo: 2,
  title: "YARE VER GÖNLÜNÜ ZARE VER GÖNLÜNÜ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/654_YARE_VER_GONLUNU_ZARE_VER_GONLUNU.txt",
),
Ilahi(
  id: 111,
  ciltNo: 2,
  title: "İKİ CİHAN TEK NOKTA GÖNÜLDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/655_IKI_CIHAN_TEK_NOKTA_GONULDE.txt",
),
Ilahi(
  id: 112,
  ciltNo: 2,
  title: "SENDE DERTLE BENDE DERTLİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/658_SENDE_DERTLE_BENDE_DERTLI.txt",
),
Ilahi(
  id: 113,
  ciltNo: 2,
  title: "SEN AYRI BEN AYRI OLMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/661_SEN_AYRI_BEN_AYRI_OLMAZ.txt",
),
Ilahi(
  id: 114,
  ciltNo: 2,
  title: "EZELİ EBEDİ GÖNÜLDE BULDUM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/663_EZELI_EBEDI_GONULDE_BULDUM.txt",
),
Ilahi(
  id: 115,
  ciltNo: 2,
  title: "GÖNLÜMÜZE GÖNLÜMÜZE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/666_GONLUMUZE_GONLUMUZE.txt",
),
Ilahi(
  id: 116,
  ciltNo: 2,
  title: "BEN SENİN KADRİNİ BİLMEDİM GÖNÜL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/667_BEN_SENIN_KADRINI_BILMEDIM_GONUL.txt",
),
Ilahi(
  id: 117,
  ciltNo: 2,
  title: "BU SABAH LEYLE İL KADİR SABAHI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/670_BU_SABAH_LEYLE_IL_KADIR_SABAHI.txt",
),
Ilahi(
  id: 118,
  ciltNo: 2,
  title: "MELEKLER BURADA RUHLAR BURADA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/671_MELEKLER_BURADA_RUHLAR_BURADA.txt",
),
Ilahi(
  id: 119,
  ciltNo: 2,
  title: "BU SEHER UYUMA SEHERİ DEĞİL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/674_BU_SEHER_UYUMA_SEHERI_DEGIL.txt",
),
Ilahi(
  id: 120,
  ciltNo: 2,
  title: "BİZDEN MAL ALACAK MÜŞTERİ NERDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/677_BIZDEN_MAL_ALACAK_MUSTERI_NERDE.txt",
),
Ilahi(
  id: 121,
  ciltNo: 2,
  title: "EL UYURDA AŞIK GÖNLÜM UYUMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/679_EL_UYURDA_ASIK_GONLUM_UYUMAZ.txt",
),
Ilahi(
  id: 122,
  ciltNo: 2,
  title: "BENİM BU KALBİMİ NİTMELİ BENİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/685_BENIM_BU_KALBIMI_NITMELI_BENIM.txt",
),
Ilahi(
  id: 123,
  ciltNo: 2,
  title: "BERİ GEL GÖNLÜNÜ ALDA BERİ GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/129_BERI_GEL_GONLUNU_ALDA_BERI_GEL.txt",
),
Ilahi(
  id: 124,
  ciltNo: 2,
  title: "BIRAK SENİ BENİ BIRAK",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/130_BIRAK_SENI_BENI_BIRAK.txt",
),
Ilahi(
  id: 125,
  ciltNo: 2,
  title: "BENİM BU DİLİMİ NİTMELİ BENİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/131_BENIM_BU_DILIMI_NITMELI_BENIM.txt",
),
Ilahi(
  id: 126,
  ciltNo: 2,
  title: "AŞIĞIN KURSUSU ARS ÜZERİNDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/132_ASIGIN_KURSUSU_ARS_UZERINDE.txt",
),
Ilahi(
  id: 127,
  ciltNo: 2,
  title: "İMTİHAN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/133_IMTIHAN.txt",
),
Ilahi(
  id: 128,
  ciltNo: 2,
  title: "GÖNÜL BİR DOST BULDU BUGÜN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/134_GONUL_BIR_DOST_BULDU_BUGUN.txt",
),
Ilahi(
  id: 129,
  ciltNo: 2,
  title: "ALLAH DERLER BİR MECLİSE UĞRADIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/135_ALLAH_DERLER_BIR_MECLISE_UGRADIM.txt",
),
Ilahi(
  id: 130,
  ciltNo: 2,
  title: "MÜRŞİD MÜRİDİNİ ARAR ŞEHERDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/136_MURSID_MURIDINI_ARAR_SEHERDE.txt",
),
Ilahi(
  id: 131,
  ciltNo: 2,
  title: "BİZDEN İSTEDİĞİN GÖNÜLDEN İSTE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/137_BIZDEN_ISTEDIGIN_GONULDEN_ISTE.txt",
),
Ilahi(
  id: 132,
  ciltNo: 2,
  title: "SENDE ONUN KALBİNDESİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/138_SENDE_ONUN_KALBINDESIN.txt",
),
Ilahi(
  id: 133,
  ciltNo: 2,
  title: "SEVEN GÖNÜL SEVDİĞİNDEN AYRILMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/139_SEVEN_GONUL_SEVDIGINDEN_AYRILMAZ.txt",
),
Ilahi(
  id: 134,
  ciltNo: 2,
  title: "BERİ GEL BERİ GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/140_BERI_GEL_BERI_GEL.txt",
),
Ilahi(
  id: 135,
  ciltNo: 2,
  title: "GÖNÜL EĞLENMEZİ EĞLENMEZİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/141_GONUL_EGLENMEZ_EGLENMEZ.txt",
),
Ilahi(
  id: 136,
  ciltNo: 2,
  title: "BİZE AŞKIN GEREK BİZE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/142_BIZE_ASKIN_GEREK_BIZE.txt",
),
Ilahi(
  id: 137,
  ciltNo: 2,
  title: "BİZE DERTLİ GÖNÜL GEREK",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/143_BIZE_DERTLI_GONUL_GEREK.txt",
),
Ilahi(
  id: 138,
  ciltNo: 2,
  title: "UNUTMA KALBİNDEN BİZİ HATIRLA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/144_UNUTMA_KALBINDEN_BIZI_HATIRLA.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=Tv5oGS7xTmw&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=15"
),
Ilahi(
  id: 139,
  ciltNo: 2,
  title: "ÇAĞIR ERENLERİ ÇAĞIR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/145_CAGIR_ERENLERI_CAGIR.txt",
),
Ilahi(
  id: 140,
  ciltNo: 2,
  title: "HAK GÖNÜLDE GÖNÜL HAKTA BERABER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/146_HAK_GONULDE_GONUL_HAKTA_BERABER.txt",
),
Ilahi(
  id: 141,
  ciltNo: 2,
  title: "BİNBİR ESMA DERDİ ÇEKER DİL BENİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/148_BINBIR_ESMA_DERDI_CEKER_DIL_BENIM.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=wmoWx3tUNzM&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=11"
),
Ilahi(
  id: 142,
  ciltNo: 2,
  title: "DAĞLAR SİZDE LALE SÜMBÜL BİTERMİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/149_DAGLAR_SIZDE_LALE_SUMBUL_BITERMI.txt",
),
Ilahi(
  id: 143,
  ciltNo: 2,
  title: "DALINIZA BÜLBÜL KONAR ÖTERMI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/150_DALINIZA_BULBUL_KONAR_OTERMI.txt",
),
Ilahi(
  id: 144,
  ciltNo: 2,
  title: "BİZE HAK YOLUNDAN İSLAM GELİYOR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/151_BIZE_HAK_YOLUNDAN_ISLAM_GELIYOR.txt",
),
Ilahi(
  id: 145,
  ciltNo: 2,
  title: "BAKTIM Kİ AÇILAN GÜLLER BAHARDA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/152_BAKTIM_KI_ACILAN_GULLER_BAHARDA.txt",
),
Ilahi(
  id: 146,
  ciltNo: 2,
  title: "BU GARİP HÜCCACDAN NE UMUYORSUN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/154_BU_GARIP_HUCCACDAN_NE_UMUYORSUN.txt",
),
Ilahi(
  id: 147,
  ciltNo: 2,
  title: "BUGÜN TOKATA BİR BÜLBÜL GELDİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/156_BUGUN_TOKATA_BIR_BULBUL_GELDI.txt",
),
Ilahi(
  id: 148,
  ciltNo: 2,
  title: "ŞEHЕRLER AĞLADI YERLER AĞLADI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/157_SEHERLER_AGLADI_YERLER_AGLADI.txt",
),
Ilahi(
  id: 149,
  ciltNo: 2,
  title: "ASLINA BİR AYNA OLANI VARDIR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/158_ASLINA_BIR_AYNA_OLANI_VARDIR.txt",
),
Ilahi(
  id: 150,
  ciltNo: 2,
  title: "MECLİSİ MUHAMMED MUSTAFAYA GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/159_MECLISI_MUHAMMED_MUSTAFAYA_GEL.txt",
),
Ilahi(
  id: 151,
  ciltNo: 2,
  title: "CAN İÇİNDE CANAN BULDA GİDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/160_CAN_ICINDE_CANAN_BULDA_GIDELIM.txt",
),
Ilahi(
  id: 152,
  ciltNo: 2,
  title: "DERDİ BENİM DERDİMDENDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/161_DERDI_BENIM_DERDIMDENDIR.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=iFJ5mQCex4E&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=13"
),
Ilahi(
  id: 153,
  ciltNo: 2,
  title: "GELİN BU HANEYE SEN SEFA GELDİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/162_GELIN_BU_HANEYE_SEN_SEFA_GELDIN.txt",
),
Ilahi(
  id: 154,
  ciltNo: 2,
  title: "HİZMET ET DE HİMMETİNE LAYIK OL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/163_HIZMET_ET_DE_HIMMETINE_LAYIK_OL.txt",
),
Ilahi(
  id: 155,
  ciltNo: 2,
  title: "SENDE BU AŞKA DÜŞEYDİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/164_SENDE_BU_ASKA_DUSEYDIN.txt",
),
Ilahi(
  id: 156,
  ciltNo: 2,
  title: "LÜTFEYLE GÜZEL ALLAHIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/165_LUTFEYLE_GUZEL_ALLAHIM.txt",
),
Ilahi(
  id: 157,
  ciltNo: 2,
  title: "ANLAR AMMA NEDEN SONRA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/166_ANLAR_AMMA_NEDEN_SONRA.txt",
),
Ilahi(
  id: 158,
  ciltNo: 2,
  title: "BABA KÖYÜNÜ ZİYARETTE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/168_BABA_KOYUNU_ZIYARETTE.txt",
),
Ilahi(
  id: 159,
  ciltNo: 2,
  title: "UYANIN GÖNÜLLER DERGAHA GELİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/169_UYANIN_GONULLER_DERGHA_GELIN.txt",
),
Ilahi(
  id: 160,
  ciltNo: 2,
  title: "HEMİ DERTTİR HEMİ DERMAN AŞK BANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/170_HEMI_DERTTIR_HEMI_DERMAN_ASK_BANA.txt",
),
Ilahi(
  id: 161,
  ciltNo: 2,
  title: "OĞLUM NE DURURSUN SEN GARİP GARİP",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/171_OGLUM_NE_DURURSUN_SEN_GARIP_GARIP.txt",
),
Ilahi(
  id: 162,
  ciltNo: 2,
  title: "UYUMA GÖNLÜM UYUMA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/172_UYUMA_GONLUM_UYUMA.txt",
),
Ilahi(
  id: 163,
  ciltNo: 2,
  title: "GEL SENİNLE HAKKA HİZMET EDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/173_GEL_SENINLE_HAKKA_HIZMET_EDELIM.txt",
),
Ilahi(
  id: 164,
  ciltNo: 2,
  title: "YOLLAR BİZİMDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/174_YOLLAR_BIZIMDIR.txt",
),
Ilahi(
  id: 165,
  ciltNo: 2,
  title: "ÇAĞLA DERYA ÇAĞLA HAKKA GİDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/175_CAGLA_DERYA_CAGLA_HAKKA_GIDELIM.txt",
),
Ilahi(
  id: 166,
  ciltNo: 2,
  title: "AŞKIN EZANİNİ OKUTTU BİZE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/176_ASKIN_EZANINI_OKUTTU_BIZE.txt",
),
Ilahi(
  id: 167,
  ciltNo: 2,
  title: "MALİKİN SIRRINA ERMEK GÜZELDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/177_MALIKIN_SIRRINA_ERMEK_GUZELDIR.txt",
),
Ilahi(
  id: 168,
  ciltNo: 2,
  title: "SEVMEN DE HOŞ SEVİLMEN DE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/178_SEVMENDE_HOS_SEVILMENDE.txt",
),
Ilahi(
  id: 169,
  ciltNo: 2,
  title: "BU NE LÜTFU İLAHİDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/179_BU_NE_LUTFU_ILAHIDIR.txt",
),
Ilahi(
  id: 170,
  ciltNo: 2,
  title: "BENİM GÖNLÜM BARDAK DEĞİL DEM İSTER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/180_BENIM_GONLUM_BARDAK_DEGIL_DEM_ISTER.txt",
),
Ilahi(
  id: 171,
  ciltNo: 2,
  title: "GEL GÖNÜL CENNETİNE DEM ÇEKELİM GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/181_GEL_GONUL_CENNETINE_DEM_CEKELIM_GEL.txt",
),
Ilahi(
  id: 172,
  ciltNo: 2,
  title: "O MİMİ SÜBHANI GÖNÜLDE BULDUM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/182_O_MIMI_SUBHANI_GONULDE_BULDUM.txt",
),
Ilahi(
  id: 173,
  ciltNo: 2,
  title: "HEM KABEDİR HEM KIBLEDİR YAR BANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/183_HEM_KABEDIR_HEM_KIBLEDIR_YAR_BANA.txt",
),
Ilahi(
  id: 174,
  ciltNo: 2,
  title: "BENİM GÖNLÜM EFENDİME BAĞLIDIR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/184_BENIM_GONLUM_EFENDIME_BAGLIDIR.txt",
),
Ilahi(
  id: 175,
  ciltNo: 2,
  title: "EL UYANDI BİZİM ELLER UYANMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/185_EL_UYANDI_BIZIM_ELLER_UYANMAZ.txt",
),
Ilahi(
  id: 176,
  ciltNo: 2,
  title: "DEMLERİNİ KİME VERDİN CELALİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/186_DEMLERINI_KIME_VERDIN_CELALI.txt",
),
Ilahi(
  id: 177,
  ciltNo: 2,
  title: "KIZ ANAM KIZ BACIM KINAN KUTLU OLSUN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/187_KIZ_ANAM_KIZ_BACIM_KINAN_KUTLU_OLSUN.txt",
),
Ilahi(
  id: 178,
  ciltNo: 2,
  title: "ANNE HAKKIN HELAL EYLE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/188_ANNE_HAKKIN_HELAL_EYLE.txt",
),
Ilahi(
  id: 179,
  ciltNo: 2,
  title: "BİZİM MÜSKÜLLÜMÜZ PİRLER HALLEDER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/189_BIZIM_MUSKULUMUZ_PIRLER_HALLEDER.txt",
),
Ilahi(
  id: 180,
  ciltNo: 2,
  title: "UYAN MECNUN UYAN BEN LEYLA GELDİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/190_UYAN_MECNUN_UYAN_BEN_LEYLA_GELDIM.txt",
),
Ilahi(
  id: 181,
  ciltNo: 2,
  title: "VAR GİT LEYLA VAR GİT MEVLAYI BULDUM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/191_VAR_GIT_LEYLA_VAR_GIT_MEVLAYI_BULDUM.txt",
),
Ilahi(
  id: 182,
  ciltNo: 2,
  title: "SİZE HÖŞ MUHABBET BİZE ELVEDA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text2/192_SIZE_HOS_MUHABBET_BIZE_ELVEDA.txt",
),
Ilahi(
  id: 1,
  ciltNo: 3,
  title: "ZİKREDELİM FİKREDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/1_ZIKREDELIM_FIKREDELIM.txt",
),
Ilahi(
  id: 2,
  ciltNo: 3,
  title: "GELİN BU DERGAHA GELİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/2_GELIN_BU_DERGAHA_GELIN.txt",
),
Ilahi(
  id: 3,
  ciltNo: 3,
  title: "GÖNÜL YARDAN YAR GÖNÜLDEN AYRILMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/3_GONUL_YARDAN_YAR_GONULDEN_AYRILMAZ.txt",
),
Ilahi(
  id: 4,
  ciltNo: 3,
  title: "DERVİŞLER PİRİNİ YERDE YATIRMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/4_DERVISLER_PIRINI_YERDE_YATIRMAZ.txt",
),
Ilahi(
  id: 5,
  ciltNo: 3,
  title: "ÖLÜM SANA NİÇİN ÇARE DERMAN BULUNMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/5_OLUM_SANA_NICIN_CARE_DERMAN_BULUNMAZ.txt",
),
Ilahi(
  id: 6,
  ciltNo: 3,
  title: "GÖNÜL YARDAN YAR GÖNÜLDEN AYRILMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/6_GONUL_YARDAN_YAR_GONULDEN_AYRILMAZ.txt",
),
Ilahi(
  id: 7,
  ciltNo: 3,
  title: "OLDUKTAN GERİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/7_OLDUKTAN_GERI.txt",
),
Ilahi(
  id: 8,
  ciltNo: 3,
  title: "BUNA NİYAZ DERLER BUNA NAZ DERLER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/8_BUNA_NIYAZ_DERLER_BUNA_NAZ_DERLER.txt",
),
Ilahi(
  id: 9,
  ciltNo: 3,
  title: "ALEMİ İSLAMA BAYRAM O BAYRAM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/9_ALEMI_ISLAMA_BAYRAM_O_BAYRAM.txt",
),
Ilahi(
  id: 10,
  ciltNo: 3,
  title: "BENİM ADIM AŞIK OLSA NE FAYDA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/10_BENIM_ADIM_ASIK_OLSA_NE_FAYDA.txt",
),
Ilahi(
  id: 11,
  ciltNo: 3,
  title: "DERD İLE DEM BERABER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/11_DERD_ILE_DEM_BERABER.txt",
),
Ilahi(
  id: 12,
  ciltNo: 3,
  title: "MUHAMMEDE GELMEZ MİSİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/12_MUHAMMEDE_GELMEZ_MISIN.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=7uoIWT-GNaI&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=20"
),
Ilahi(
  id: 13,
  ciltNo: 3,
  title: "İNŞALLAH UYANACAĞIZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/13_INSALLAH_UYANACAGIZ.txt",
),
Ilahi(
  id: 14,
  ciltNo: 3,
  title: "ŞEYHİ SIRRINI GÖRSEN NE FAYDA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/14_SEYHI_SIRRINI_GORSEN_NE_FAYDA.txt",
),
Ilahi(
  id: 15,
  ciltNo: 3,
  title: "NEFSİNİ BİL NEFSİNİ BİL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/15_NEFSINI_BIL_NEFSINI_BIL.txt",
),
Ilahi(
  id: 16,
  ciltNo: 3,
  title: "GÖNÜL BULUNURDA BUGÜN BULUNMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/16_GONUL_BULUNURDA_BUGUN_BULUNMAZ.txt",
),
Ilahi(
  id: 17,
  ciltNo: 3,
  title: "NE ZAMAN UYANACAKSIN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/17_NE_ZAMAN_UYANACAKSIN.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=oQdRaxj-qfs&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=17"
),
Ilahi(
  id: 18,
  ciltNo: 3,
  title: "NOLUR YA RAB NOLUR YA RAB",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/18_NOLUR_YA_RAB_NOLUR_YA_RAB.txt",
),
Ilahi(
  id: 19,
  ciltNo: 3,
  title: "BÜLBÜLÜ BİLMEZLER GÜLÜ BİLMEZLER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/19_BULBULU_BILMEZLER_GULU_BILMEZLER.txt",
),
Ilahi(
  id: 20,
  ciltNo: 3,
  title: "OLANA KURBAN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/20_OLANA_KURBAN.txt",
),
Ilahi(
  id: 21,
  ciltNo: 3,
  title: "GEL EFENDİM GEL GEL SULTANIM GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/21_GEL_EFENDIM_GEL_GEL_SULTANIM_GEL.txt",
),
Ilahi(
  id: 22,
  ciltNo: 3,
  title: "İHRAMCI ZADENİN ELİ VAR BİZDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/22_IHRAMCI_ZADENIN_ELI_VAR_BIZDE.txt",
),
Ilahi(
  id: 23,
  ciltNo: 3,
  title: "HAYIF SANA YAZIK SANA VAH SANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/23_HAYIF_SANA_YAZIK_SANA_VAH_SANA.txt",
),
Ilahi(
  id: 24,
  ciltNo: 3,
  title: "SENDE GAFLETTESİN BENDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/24_SENDE_GAFLETTESIN_BENDE.txt",
),
Ilahi(
  id: 25,
  ciltNo: 3,
  title: "GÜNDE KALAN İSİM BANA BAYRAM SAYILMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/25_GUNDE_KALAN_ISIM_BANA_BAYRAM_SAYILMAZ.txt",
),
Ilahi(
  id: 26,
  ciltNo: 3,
  title: "KURAN MUHAMMEDE İNDİ BU GECE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/26_KURAN_MUHAMMEDE_INDI_BU_GECE.txt",
),
Ilahi(
  id: 27,
  ciltNo: 3,
  title: "BEN HAKTAYIM HAKTA BENDE DEYİNCE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/27_BEN_HAKTAYIM_HAKTA_BENDE_DEYINCE.txt",
),
Ilahi(
  id: 28,
  ciltNo: 3,
  title: "ALDIN BENİ YAD ELLERE GÖTÜRDÜN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/28_ALDIN_BENI_YAD_ELLERE_GOTURDUN.txt",
),
Ilahi(
  id: 29,
  ciltNo: 3,
  title: "GÜLDE BİZİM GÖLDE BİZİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/29_GULDE_BIZIM_GOLDE_BIZIM.txt",
),
Ilahi(
  id: 30,
  ciltNo: 3,
  title: "BEN PERİŞAN DERİM SEN OLMAZ DERSİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/30_BEN_PERISAN_DERIM_SEN_OLMAZ_DERSIN.txt",
),
Ilahi(
  id: 31,
  ciltNo: 3,
  title: "AYIK OL GÖNLÜNÜ HAKKA VERELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/31_AYIK_OL_GONLUNU_HAKKA_VERELIM.txt",
),
Ilahi(
  id: 32,
  ciltNo: 3,
  title: "SEFA GELDİNİZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/32_SEFA_GELDINIZ.txt",
),
Ilahi(
  id: 33,
  ciltNo: 3,
  title: "AKLINI BAŞINDAN ALAN AŞKIDIR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/33_AKLINI_BASINDAN_ALAN_ASKIDIR.txt",
),
Ilahi(
  id: 34,
  ciltNo: 3,
  title: "MEVLAM BUGÜN BİZE İZİN VERECEK",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/34_MEVLAM_BUGUN_BIZE_IZIN_VERECEK.txt",
),
Ilahi(
  id: 35,
  ciltNo: 3,
  title: "NE ARZUN VAR NE MERAMIN VAR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/35_NE_ARZUN_VAR_NE_MERAMIN_VAR.txt",
),
Ilahi(
  id: 36,
  ciltNo: 3,
  title: "GELİN BİZ GÖNLE GİDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/36_GELIN_BIZ_GONLE_GIDELIM.txt",
),
Ilahi(
  id: 37,
  ciltNo: 3,
  title: "MAŞUK OLAN ANLAR AŞKIN DİLİNDEN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/37_MASUK_OLAN_ANLAR_ASKIN_DILINDEN.txt",
),
Ilahi(
  id: 38,
  ciltNo: 3,
  title: "SEN NEREDESİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/38_SEN_NEREDESIN.txt",
),
Ilahi(
  id: 39,
  ciltNo: 3,
  title: "HALA BU GAFLETTEN UYANMADIN MI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/39_HALA_BU_GAFLETTEN_UYANMADIN_MI.txt",
),
Ilahi(
  id: 40,
  ciltNo: 3,
  title: "AL SÜNNETİ RESULÜN AL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/40_AL_SUNNETI_RESULUN_AL.txt",
),
Ilahi(
  id: 41,
  ciltNo: 3,
  title: "ANNEM BENİ ÇAĞIRIYOR GİDERİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/41_ANNEM_BENI_CAGIRIYOR_GIDERIM.txt",
),
Ilahi(
  id: 42,
  ciltNo: 3,
  title: "BEN BENİ BULDUM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/42_BEN_BENI_BULDUM.txt",
),
Ilahi(
  id: 43,
  ciltNo: 3,
  title: "MÜJDE MUHAMMED GELİYOR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/43_MUJDE_MUHAMMED_GELIYOR.txt",
),
Ilahi(
  id: 44,
  ciltNo: 3,
  title: "KAÇMA BU SOHBETTEN KAÇMA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/44_KACMA_BU_SOHBETTEN_KACMA.txt",
),
Ilahi(
  id: 45,
  ciltNo: 3,
  title: "EL VER MÜRŞİDE MÜRŞİDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/45_EL_VER_MURSIDE_MURSIDE.txt",
),
Ilahi(
  id: 46,
  ciltNo: 3,
  title: "MEVLA AŞKI NE GÜZELDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/46_MEVLA_ASKI_NE_GUZELDIR.txt",
),
Ilahi(
  id: 47,
  ciltNo: 3,
  title: "BU AŞK BİLİNMEZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/47_BU_ASK_BILINMEZ.txt",
),
Ilahi(
  id: 48,
  ciltNo: 3,
  title: "BENİM ÜSTADIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/48_BENIM_USTADIM.txt",
),
Ilahi(
  id: 49,
  ciltNo: 3,
  title: "MEVLA M KADİR GECESİNDE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/49_MEVLA_M_KADIR_GECESINDE.txt",
),
Ilahi(
  id: 50,
  ciltNo: 3,
  title: "BANA BİR HAL OLDU BANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/50_BANA_BIR_HAL_OLDU_BANA.txt",
),
Ilahi(
  id: 51,
  ciltNo: 3,
  title: "YORULUR MU YORULUR MU",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/51_YORULUR_MU_YORULUR_MU.txt",
),
Ilahi(
  id: 52,
  ciltNo: 3,
  title: "BENİM DERDİM YAR ELİNDEN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/52_BENIM_DERDIM_YAR_ELINDEN.txt",
),
Ilahi(
  id: 53,
  ciltNo: 3,
  title: "NİÇİN DERVİŞLERE HOR BAKIYORSUN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/53_NICIN_DERVISLERE_HOR_BAKIYORSUN.txt",
),
Ilahi(
  id: 54,
  ciltNo: 3,
  title: "BU KANDİLİ REGAİPTİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/54_BU_KANDILI_REGAIPTIR.txt",
),
Ilahi(
  id: 55,
  ciltNo: 3,
  title: "NEYLEYİM AH NEYLEYİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/55_NEYLEYIM_AH_NEYLEYIM.txt",
),
Ilahi(
  id: 56,
  ciltNo: 3,
  title: "YETİŞ DAR GÜNÜMÜZ GEL İMDADA GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/56_YETIS_DAR_GUNUMUZ_GEL_IMDADA__GEL.txt",
),
Ilahi(
  id: 57,
  ciltNo: 3,
  title: "BİZE EHLİ İLİM GELDİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/57_BIZE_EHLI_ILIM_GELDI.txt",
),
Ilahi(
  id: 58,
  ciltNo: 3,
  title: "GÖSTER CEMALİNİ GÖREYİM CANAN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/58_GOSTER_CEMALINI_GOREYIM_CANAN.txt",
),
Ilahi(
  id: 59,
  ciltNo: 3,
  title: "ELVEDA VATANIM SANA ELVEDA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/59_ELVEDA_VATANIM_SANA_ELVEDA.txt",
),
Ilahi(
  id: 60,
  ciltNo: 3,
  title: "YOLUMUZ SİVASA GİDER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/60_YOLUMUZ_SIVASA_GIDER.txt",
),
Ilahi(
  id: 61,
  ciltNo: 3,
  title: "NE GÜNDÜZ DURURUZ NE DE BİR GECE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/61_NE_GUNDUZ_DURURUZ_NE_DE_BIR_GECE.txt",
),
Ilahi(
  id: 62,
  ciltNo: 3,
  title: "GİDEK DESEM GİTMEZ MİSİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/62_GIDEK_DESEM_GITMEZ_MISIN.txt",
),
Ilahi(
  id: 63,
  ciltNo: 3,
  title: "YİNE GÖNLE GELECEKSİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/63_YINE_GONLE_GELECEKSIN.txt",
),
Ilahi(
  id: 64,
  ciltNo: 3,
  title: "KALBİNLE GEL GÖNLÜNLE GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/64_KALBINLE_GEL_GONLUNLE_GEL.txt",
),
Ilahi(
  id: 65,
  ciltNo: 3,
  title: "KALBİMDESİN BENİM YAVRUM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/65_KALBIMDESIN_BENIM_YAVRUM.txt",
),
Ilahi(
  id: 66,
  ciltNo: 3,
  title: "GÖNLÜMÜZDE HAK VAR BİZİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/66_GONLUMUZDE_HAK_VAR_BIZIM.txt",
),
Ilahi(
  id: 67,
  ciltNo: 3,
  title: "EFENDİNİN KIZINA DÜĞÜN BEYİTİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/67_EFENDININ_KIZINA_DUGUN_BEYITI.txt",
),
Ilahi(
  id: 68,
  ciltNo: 3,
  title: "MUHAMMED'İN AŞKINDANDIR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/68_MUHAMMED_IN_ASKINDANDIR.txt",
),
Ilahi(
  id: 69,
  ciltNo: 3,
  title: "SAHRA SAKİN DERVİŞ SAKİN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/69_SAHRA_SAKIN_DERVIS_SAKIN.txt",
),
Ilahi(
  id: 70,
  ciltNo: 3,
  title: "HANİ DERVİŞ GÖNLÜN HANİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/70_HANI_DERVIS_GONLUN_HANI.txt",
),
Ilahi(
  id: 71,
  ciltNo: 3,
  title: "DERVİŞLERİN HALİ TÜRLÜ TÜRLÜDÜR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/71_DERVISLERIN_HALI_TURLU_TURLUDUR.txt",
),
Ilahi(
  id: 72,
  ciltNo: 3,
  title: "SENDE GÖNÜL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/72_SENDE_GONUL.txt",
),
Ilahi(
  id: 73,
  ciltNo: 3,
  title: "BENİ BENDE SANMAN BENİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/73_BENI_BENDE_SANMAN_BENI.txt",
),
Ilahi(
  id: 74,
  ciltNo: 3,
  title: "BEN ANLARIM EL ANLAMAZ NE FAYDA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/74_BEN_ANLARIM_EL_ANLAMAZ_NE_FAYDA.txt",
),
Ilahi(
  id: 75,
  ciltNo: 3,
  title: "GÖNÜL GEL SENİNLE ALLAH DİYELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/75_GONUL_GEL_SENINLE_ALLAH_DIYELIM.txt",
),
Ilahi(
  id: 76,
  ciltNo: 3,
  title: "DURSUN DEDİKTE DURMADI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/76_DURSUN_DEDIKTE_DURMADI.txt",
),
Ilahi(
  id: 77,
  ciltNo: 3,
  title: "BU DERT BENİ ELDEN ELE SALIYOR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/77_BU_DERT_BENI_ELDEN_ELE_SALIYOR.txt",
),
Ilahi(
  id: 78,
  ciltNo: 3,
  title: "BENİM GÖNLÜM MUHAMMEDEN AYRILMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/78_BENIM_GONLUM_MUHAMMEDEN_AYRILMAZ.txt",
),
Ilahi(
  id: 79,
  ciltNo: 3,
  title: "ALACAKSIN BU MEYDANDA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/79_ALACAKSIN_BU_MEYDANDA.txt",
),
Ilahi(
  id: 80,
  ciltNo: 3,
  title: "BU MEYDANI ARAFATTIR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/80_BU_MEYDANI_ARAFATTIR.txt",
),
Ilahi(
  id: 81,
  ciltNo: 3,
  title: "BÜLBÜL BÜLBÜLDÜR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/81_BULBUL_BULBULDUR.txt",
),
Ilahi(
  id: 82,
  ciltNo: 3,
  title: "GEL ALLAHA GİDELİM GEL",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/82_GEL_ALLAHA_GIDELIM_GEL.txt",
),
Ilahi(
  id: 83,
  ciltNo: 3,
  title: "GÖRENDE HOŞ GÖRMEYEN DE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/83_GORENDE_HOS_GORMEYENDE.txt",
),
Ilahi(
  id: 84,
  ciltNo: 3,
  title: "BAK BİZİM GÖNLÜMÜZ HAKTA BİRLEŞTİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/84_BAK_BIZIM_GONLUMUZ_HAKTA_BIRLESTI.txt",
),
Ilahi(
  id: 85,
  ciltNo: 3,
  title: "BİZ BU DERTLERİ YANARKEN",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/85_BIZ_BU_DERTLERI_YANARKEN.txt",
),
Ilahi(
  id: 86,
  ciltNo: 3,
  title: "NASİP İSE BİR ŞEY OLUR İNŞAALLAH",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/86_NASIP_ISE_BIRSEY_OLUR_INSAALLAH.txt",
),
Ilahi(
  id: 87,
  ciltNo: 3,
  title: "BEN DE DERMANA MUHTACIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/87_BENDE_DERMANA_MUHTACIM.txt",
),
Ilahi(
  id: 88,
  ciltNo: 3,
  title: "BUGÜN BURDA DERTLEŞELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/88_BUGUN_BURDA_DERTLESELIM.txt",
),
Ilahi(
  id: 89,
  ciltNo: 3,
  title: "MUHABBET DEMİNE YENİ BAŞLADIK",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/89_MUHABBET_DEMINE_YENI_BASLADIK.txt",
),
Ilahi(
  id: 90,
  ciltNo: 3,
  title: "GÖNÜL GEL SENİNLE HAKKA GİDELİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/90_GONUL_GEL_SENINLE_HAKKA_GIDELIM.txt",
),
Ilahi(
  id: 91,
  ciltNo: 3,
  title: "BEN ONUN DİLİYİM DİLİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/91_BEN_ONUN_DILIYIM_DILI.txt",
),
Ilahi(
  id: 92,
  ciltNo: 3,
  title: "BEN GÖNÜLDEN AYRILAMAM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/92_BEN_GONULDEN_AYRILAMAM.txt",
),
Ilahi(
  id: 93,
  ciltNo: 3,
  title: "SENİ SÖYLETİRLER SENİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/93_SENI_SOYLETIRLER_SENI.txt",
),
Ilahi(
  id: 94,
  ciltNo: 3,
  title: "EYLENME GÖNLÜM EYLENME",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/94_EYLENME_GONLUM_EYLENME.txt",
),
Ilahi(
  id: 95,
  ciltNo: 3,
  title: "BEN NİDEYİM GÖNÜL SENİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/95_BEN_NIDEYIM_GONUL_SENI.txt",
),
Ilahi(
  id: 96,
  ciltNo: 3,
  title: "ÖZDEN ÖZE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/96_OZDEN_OZE.txt",
),
Ilahi(
  id: 97,
  ciltNo: 3,
  title: "GÖNÜL EHLİ GÖNÜL EHLİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/97_GONUL_EHLI_GONUL_EHLI.txt",
),
Ilahi(
  id: 98,
  ciltNo: 3,
  title: "ABDULKADİR GİBİ BİR ER BULUNMAZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/98_ABDULKADIR_GIBI_BIR_ER_BULUNMAZ.txt",
),
Ilahi(
  id: 99,
  ciltNo: 3,
  title: "BOZMA SEN GÖNLÜNÜ BOZMA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/99_BOZMA_SEN_GONLUNU_BOZMA.txt",
),
Ilahi(
  id: 100,
  ciltNo: 3,
  title: "SECDELERE KONAN BİR BAŞ OLALIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/100_SECDELERE_KONAN_BIR_BAS_OLALIM.txt",
),
Ilahi(
  id: 101,
  ciltNo: 3,
  title: "GÖNLÜ BİR KARDEŞİN GÖNLÜ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/101_GONLU_BIR_KARDESIN_GONLU.txt",
),
Ilahi(
  id: 102,
  ciltNo: 3,
  title: "YÜRÜ MEYDANA HELE MEYDANA",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/102_YURU_MEYDANA_HELE_MEYDANA.txt",
),
Ilahi(
  id: 103,
  ciltNo: 3,
  title: "NE SEN BİZİ UNUT NE DE BİZ SENİ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/103_NE_SEN_BIZI_UNUT_NEDE_BIZ_SENI.txt",
),
Ilahi(
  id: 104,
  ciltNo: 3,
  title: "GELİN HAKKA BİR ARZUHAL YAZALIM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/104_GELIN_HAKKA_BIR_ARZUHAL_YAZALIM.txt",
  youtubeUrl: "https://www.youtube.com/watch?v=JQdsGTq21uA&list=PLpgrqRH2RxmlNcso4VjnLXmn4ZjK24XZF&index=4"
),
Ilahi(
  id: 105,
  ciltNo: 3,
  title: "OLMAZ MI OLMAZ MI",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/105_OLMAZMI_OLMAZMI.txt",
),
Ilahi(
  id: 106,
  ciltNo: 3,
  title: "GİTTİĞİN ELLERDEN BİZE HABER VER",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/106_GITTIGIN_ELLERDEN_BIZE_HABER_VER.txt",
),
Ilahi(
  id: 107,
  ciltNo: 3,
  title: "BİLMEZ MİYİZ BİZ",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/107_BILMEZMIYIZ_BIZ.txt",
),
Ilahi(
  id: 108,
  ciltNo: 3,
  title: "GÖNÜLDE BULMAK İSTEDİM",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/108_GONULDE_BULMAK_ISTEDIM.txt",
),
Ilahi(
  id: 109,
  ciltNo: 3,
  title: "DEVRANIMIZ GÖNÜLDEDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/109_DEVRANIMIZ_GONULDEDIR.txt",
),
Ilahi(
  id: 110,
  ciltNo: 3,
  title: "GÖNÜLLER GAFLETTE HALLER GAFLETTE",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/110_GONULLER_GAFLETTE_HALLER_GAFLETTE.txt",
),
Ilahi(
  id: 111,
  ciltNo: 3,
  title: "GÖNÜLDEKİ HAC BİZİMDİR",
  author: "Bünyamin Yıldırım Efendi Hazretleri",
  category: "İlahi",
  audioPath: "null",
  lyricsPath: "assets/text3/111_GONULDEKI_HAC_BIZIMDIR.txt",
),
];

// ─────────────────────────────────────────────
// GLOBAL SES SERVİSİ — Sayfa geçişlerinde ses kontrolü
// ─────────────────────────────────────────────
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer player = AudioPlayer();
  String? currentPath;

  Future<void> stop() async {
    await player.stop();
    currentPath = null;
  }

  void dispose() {
    player.dispose();
  }
}

// ─────────────────────────────────────────────
// ANA SAYFA
// ─────────────────────────────────────────────
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  Set<int> favoriteIds = {};

  static const List<String> _pageTitles = [
  "Hayatı", "Önsöz", "Cilt 1", "Cilt 2", "Cilt 3",
  "Galeri", "İlahi & Sohbetler", "Favorilerim",
  ];

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // ← YENİ
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('favorites') ?? [];
    setState(() {
      favoriteIds = saved.map((e) => int.parse(e)).toSet();
    });
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'favorites',
      favoriteIds.map((e) => e.toString()).toList(),
    );
  }

  void toggleFavorite(int id) {
    setState(() {
      if (favoriteIds.contains(id)) {
        favoriteIds.remove(id);
      } else {
        favoriteIds.add(id);
      }
    });
    _saveFavorites(); // ← YENİ
  }

  // ... geri kalan kod değişmez

Widget _buildPage(int index) {
  switch (index) {
    case 0: return const BiographyPage();
    case 1: return const PrefacePage();
    case 2: return IlahiListPage(ciltNo: 1, favoriteIds: favoriteIds, onFavoriteToggle: toggleFavorite);
    case 3: return IlahiListPage(ciltNo: 2, favoriteIds: favoriteIds, onFavoriteToggle: toggleFavorite);
    case 4: return IlahiListPage(ciltNo: 3, favoriteIds: favoriteIds, onFavoriteToggle: toggleFavorite);
    case 5: return const GalleryPage();
    case 6: return const SohbetlerPage();
    case 7: return FavoritesPage(favoriteIds: favoriteIds, onFavoriteToggle: toggleFavorite);
    default: return const BiographyPage();
  }
}
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
      ),
      drawer: _buildDrawer(isDark),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: KeyedSubtree(
          key: ValueKey(_selectedIndex),
          child: _buildPage(_selectedIndex),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildBottomNav(bool isDark) {
    final bg = isDark ? AppColors.darkCard : Colors.white;
    final sel = AppColors.primary;
    final unsel = isDark ? AppColors.darkTextSecondary : const Color(0xFFADB5BD);
    return Container(
      decoration: BoxDecoration(
        color: bg,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, -2))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomNavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: "Hayatı", selected: _selectedIndex == 0, selectedColor: sel, unselectedColor: unsel, onTap: () => setState(() => _selectedIndex = 0)),
  _BottomNavItem(icon: Icons.auto_stories_outlined, activeIcon: Icons.auto_stories_rounded, label: "Önsöz", selected: _selectedIndex == 1, selectedColor: sel, unselectedColor: unsel, onTap: () => setState(() => _selectedIndex = 1)),
  _BottomNavItem(icon: Icons.menu_book_outlined, activeIcon: Icons.menu_book_rounded, label: "Cilt 1", selected: _selectedIndex == 2, selectedColor: sel, unselectedColor: unsel, onTap: () => setState(() => _selectedIndex = 2)),
  _BottomNavItem(icon: Icons.menu_book_outlined, activeIcon: Icons.menu_book_rounded, label: "Cilt 2", selected: _selectedIndex == 3, selectedColor: sel, unselectedColor: unsel, onTap: () => setState(() => _selectedIndex = 3)),
  _BottomNavItem(icon: Icons.menu_book_outlined, activeIcon: Icons.menu_book_rounded, label: "Cilt 3", selected: _selectedIndex == 4, selectedColor: sel, unselectedColor: unsel, onTap: () => setState(() => _selectedIndex = 4)),
  _BottomNavItem(icon: Icons.photo_library_outlined, activeIcon: Icons.photo_library_rounded, label: "Galeri", selected: _selectedIndex == 5, selectedColor: sel, unselectedColor: unsel, onTap: () => setState(() => _selectedIndex = 5)),
  _BottomNavItem(icon: Icons.play_circle_outline_rounded, activeIcon: Icons.play_circle_rounded, label: "Sohbet", selected: _selectedIndex == 6, selectedColor: sel, unselectedColor: unsel, onTap: () => setState(() => _selectedIndex = 6)),
              ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(bool isDark) {
    return Drawer(
      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer başlık
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [const Color(0xFF1B3A2A), const Color(0xFF0F2318)]
                      : [const Color(0xFFE8F5E9), const Color(0xFFC8E6C9)],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/bunyamin_efendi.jpg",
                        width: 82,
                        height: 82,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 82,
                          height: 82,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withOpacity(0.15),
                          ),
                          child: const Icon(Icons.person, size: 48, color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Bünyamin Efendi",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "İlahiler Külliyatı",
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                children: [
  _drawerTile(0, Icons.person_outline_rounded, Icons.person_rounded, "Hayatı", isDark),
  _drawerTile(1, Icons.auto_stories_outlined, Icons.auto_stories_rounded, "Önsöz", isDark),
  const Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Divider(height: 1),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Text(
      "İLAHİLER",
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
      ),
    ),
  ),
  _drawerTile(2, Icons.menu_book_outlined, Icons.menu_book_rounded, "Cilt 1", isDark),
  _drawerTile(3, Icons.menu_book_outlined, Icons.menu_book_rounded, "Cilt 2", isDark),
  _drawerTile(4, Icons.menu_book_outlined, Icons.menu_book_rounded, "Cilt 3", isDark),
  const Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Divider(height: 1),
  ),
  _drawerTile(5, Icons.photo_library_outlined, Icons.photo_library_rounded, "Galeri", isDark),
  _drawerTile(6, Icons.play_circle_outline_rounded, Icons.play_circle_rounded, "İlahi & Sohbetler", isDark),
  _drawerTile(7, Icons.star_outline_rounded, Icons.star_rounded, "Favorilerim", isDark),
],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerTile(int index, IconData icon, IconData activeIcon, String label, bool isDark) {
    final selected = _selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: selected
            ? AppColors.primary.withOpacity(isDark ? 0.2 : 0.1)
            : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(
          selected ? activeIcon : icon,
          color: selected ? AppColors.primary : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
          size: 22,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 15,
            color: selected
                ? AppColors.primary
                : (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
          ),
        ),
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () {
          setState(() => _selectedIndex = index);
          Navigator.pop(context);
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ALT NAVİGASYON ELEMAN WİDGET'I
// ─────────────────────────────────────────────
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 52,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: selected ? selectedColor.withOpacity(0.12) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                selected ? activeIcon : icon,
                size: 22,
                color: selected ? selectedColor : unselectedColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                color: selected ? selectedColor : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ─────────────────────────────────────────────
// BİYOGRAFİ SAYFASI
// ─────────────────────────────────────────────
class BiographyPage extends StatelessWidget {
  const BiographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        // Kapak görseli
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            "assets/images/bunyamin_efendi.jpg",
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary.withOpacity(0.2), AppColors.primary.withOpacity(0.05)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(Icons.person, size: 90, color: AppColors.primary),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // İsim kartı
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.15),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "BÜNYAMİN YILDIRIM (k.s.) HAZRETLERİ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "1943 — 1993",
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 16),

ElevatedButton.icon(
  onPressed: () {
    Share.share(
      "Bir Gönülden Bir Gönüle uygulamasını indir:\n"
      "https://play.google.com/store/apps/details?id=com.fktstudio.birgonuldenbirgonule",
    );
  },
  icon: const Icon(Icons.share_rounded),
  label: const Text("Uygulamayı Paylaş"),
),
        
        // Biyografi metni
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            "Sivas/İmranlı kazasına bağlı UYANIK (Bafsu) köyünde 1943 yılında dünyaya geldi. "
            "İlk dini bilgilerini köy imamlığı yapan babası Molla Recep'ten aldı. "
            "Çocukluk yıllarında tasavvuf arayışı ve özlemiyle yazdığı mısralar dikkati çekerdi. "
            "Onun bu özlemi, Nakşibendi / Halidiyye kolu şeyhi Kutbul Azam olarak bilinen "
            "İsmail Hakkı ÖZTOPRAK (k.s.) Hazretlerine intisap etmesine vesile oldu.\n\n"
            "Henüz on altı yaşında olmasına rağmen ezelindeki bu cevheri manada gören şeyhi, "
            "Bünyamin (k.s.)'nin ifadesiyle ömrünün sonuna kadar yapacağı hizmetlere vesile olan "
            "aşk-ı ilahiyi gönlüne nakşetmiştir.\n\n"
            "Şeyhinin 1989 yılında vefatından sonra manevi bir işaretle İstanbul Esatpaşa'ya yerleşerek "
            "orada irşad görevini sürdürmüştür. Anadolu'nun köy ve kasabalarını dolaşarak "
            "emr-i bil marufda bulunmuştur.\n\n"
            "Evinde 17 Mart 1993 Perşembe günü Rabbi'sine rabıtada iken vuslata ermiş, arkasında "
            "binlerce kalbi onun sevgisiyle dolu, gözü yaşlı müridler bırakmıştır. "
            "Türbesi Ümraniye/Kocatepe Kabristanı'ndadır.",          
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
            
              
              
            ),
          ),
        ),
      ],
    );
  }
}


// ─────────────────────────────────────────────
// ÖNSÖZ SAYFASI
// ─────────────────────────────────────────────
class PrefacePage extends StatelessWidget {
  const PrefacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيمِ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "BİSMİLLAHİRRAHMANİRRAHİM",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                "Her şeyin mutlak sahibi\n"
                "Allah-u Teâlâ Hazretlerine sonsuz\n"
                "hamdu senalar olsun.\n\n"
                "Efendimiz Hazreti Muhammed Mustafa (s.a.v.)'e\n"
                "sonsuz selatu selamlar olsun.\n\n"
                "Ve bu selatu selamlar bütün peygamberleri,\n"
                "velileri ve kıyamete kadar gelecek olan cümle\n"
                "mü'minleri kuşatsın. Amin.\n\n"
                "Menbağı Kur'an ve Sünnet olan tasavvufi hayat,\n"
                "İslâm şeriatını en güzel bir şekilde yaşama\n"
                "tarzıdır. Bu yolun öğretmenleri; mürşidi kamil,\n"
                "şeyh, arifi billah adlarıyla bilinen Hak dostlarıdır.\n\n"
                "İşte bu dostlardan bir tanesinin ilahi feyiz ve\n"
                "muhabbet ile gönlünden yansıyan beyitlerini\n"
                "coşkuyla okuyacaksınız.",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.75,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// İLAHİ LİSTE SAYFASI
// ─────────────────────────────────────────────
class IlahiListPage extends StatefulWidget {
  final int ciltNo;
  final Set<int> favoriteIds;
  final Function(int) onFavoriteToggle;

  const IlahiListPage({
    super.key,
    required this.ciltNo,
    required this.favoriteIds,
    required this.onFavoriteToggle,
  });

  @override
  State<IlahiListPage> createState() => _IlahiListPageState();
}

class _IlahiListPageState extends State<IlahiListPage> {
  String searchText = "";
  int sortMode = 0; // 0=normal, 1=A-Z, 2=Z-A
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filtered = allIlahiler.where((ilahi) {
      return ilahi.ciltNo == widget.ciltNo &&
          ilahi.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    if (sortMode == 1) filtered.sort((a, b) => a.title.compareTo(b.title));
    if (sortMode == 2) filtered.sort((a, b) => b.title.compareTo(a.title));

    return Column(
      children: [
        // Arama çubuğu
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => searchText = v),
                  decoration: InputDecoration(
                    hintText: "İlahi ara...",
                    prefixIcon: const Icon(Icons.search_rounded, size: 20),
                    suffixIcon: searchText.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => searchText = "");
                            },
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _SortButton(
                mode: sortMode,
                onTap: () => setState(() => sortMode = (sortMode + 1) % 3),
              ),
            ],
          ),
        ),
        // Sayı bilgisi
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
          child: Row(
            children: [
              Text(
                "${filtered.length} ilahi",
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        // Liste
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search_off_rounded,
                          size: 56,
                          color: isDark
                              ? AppColors.darkTextSecondary.withOpacity(0.4)
                              : AppColors.textSecondary.withOpacity(0.3)),
                      const SizedBox(height: 12),
                      Text(
                        "İlahi bulunamadı",
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final ilahi = filtered[index];
                    final isFav = widget.favoriteIds.contains(ilahi.id);
                    return _IlahiCard(
                      ilahi: ilahi,
                      isFavorite: isFav,
                      index: index + 1,
                      onFavoriteToggle: () => widget.onFavoriteToggle(ilahi.id),
                      onTap: () {
                        AudioService().stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => IlahiDetailPage(
                              ilahi: ilahi,
                              isFavorite: isFav,
                              onFavoriteToggle: widget.onFavoriteToggle,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _SortButton extends StatelessWidget {
  final int mode;
  final VoidCallback onTap;

  const _SortButton({required this.mode, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final icons = [Icons.sort_rounded, Icons.arrow_downward_rounded, Icons.arrow_upward_rounded];
    final labels = ["Sırala", "A→Z", "Z→A"];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? const Color(0xFF2A3545) : Colors.grey.shade200,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icons[mode], size: 18, color: AppColors.primary),
            const SizedBox(width: 5),
            Text(
              labels[mode],
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IlahiCard extends StatelessWidget {
  final Ilahi ilahi;
  final bool isFavorite;
  final int index;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const _IlahiCard({
    required this.ilahi,
    required this.isFavorite,
    required this.index,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF2A3545) : const Color(0xFFF0F0F0),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              // Sıra numarası
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Text(
                    "$index",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Başlık
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ilahi.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (ilahi.hasAudio) ...[
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(Icons.music_note_rounded,
                              size: 11, color: AppColors.primary.withOpacity(0.7)),
                          const SizedBox(width: 3),
                          Text(
                            "Ses mevcut",
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.primary.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              // Favori butonu
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: isFavorite ? Colors.amber.shade600 : Colors.grey.shade400,
                  size: 22,
                ),
                onPressed: onFavoriteToggle,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
              const Icon(Icons.chevron_right_rounded, size: 20, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FAVORİLER SAYFASI
// ─────────────────────────────────────────────
class FavoritesPage extends StatelessWidget {
  final Set<int> favoriteIds;
  final Function(int) onFavoriteToggle;

  const FavoritesPage({
    super.key,
    required this.favoriteIds,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final favorites =
        allIlahiler.where((ilahi) => favoriteIds.contains(ilahi.id)).toList();

    if (favorites.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star_outline_rounded,
                size: 72,
                color: isDark
                    ? AppColors.darkTextSecondary.withOpacity(0.3)
                    : AppColors.textSecondary.withOpacity(0.2)),
            const SizedBox(height: 16),
            Text(
              "Henüz favori eklenmedi",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "İlahilerdeki ⭐ ikonuna dokunun",
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? AppColors.darkTextSecondary.withOpacity(0.6)
                    : AppColors.textSecondary.withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final ilahi = favorites[index];
        return _IlahiCard(
          ilahi: ilahi,
          isFavorite: true,
          index: index + 1,
          onFavoriteToggle: () => onFavoriteToggle(ilahi.id),
          onTap: () {
            AudioService().stop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => IlahiDetailPage(
                  ilahi: ilahi,
                  isFavorite: true,
                  onFavoriteToggle: onFavoriteToggle,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// İLAHİ DETAY SAYFASI — Modern Ses Oynatıcı
// ─────────────────────────────────────────────
class IlahiDetailPage extends StatefulWidget {
  final Ilahi ilahi;
  final bool isFavorite;
  final Function(int) onFavoriteToggle;

  const IlahiDetailPage({
    super.key,
    required this.ilahi,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  State<IlahiDetailPage> createState() => _IlahiDetailPageState();
}

class _IlahiDetailPageState extends State<IlahiDetailPage> {
  final _audio = AudioService();

  bool _isPlaying = false;
  bool _isLoading = false;
  bool _isLoaded = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _setupListeners();
  }

  void _setupListeners() {
    _audio.player.positionStream.listen((pos) {
      if (mounted) setState(() => _position = pos);
    });

    _audio.player.durationStream.listen((dur) {
      if (mounted && dur != null) setState(() => _duration = dur);
    });

    _audio.player.playerStateStream.listen((state) {
      if (!mounted) return;
      final playing = state.playing;
      final completed = state.processingState == ProcessingState.completed;

      setState(() {
        _isPlaying = playing && !completed;
        if (completed) {
          _position = Duration.zero;
          _isLoaded = false;
        }
      });
    });
  }

  Future<void> _togglePlay() async {
    if (!widget.ilahi.hasAudio) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Bu ilahi için ses dosyası henüz eklenmemiş."),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    try {
      if (!_isLoaded) {
        setState(() => _isLoading = true);
        // Önceki sesi durdur
        if (_audio.currentPath != widget.ilahi.audioPath) {
          await _audio.player.stop();
        }
        await _audio.player.setAsset(widget.ilahi.audioPath);
        _audio.currentPath = widget.ilahi.audioPath;
        setState(() {
          _isLoaded = true;
          _isLoading = false;
        });
        await _audio.player.play();
      } else {
        if (_isPlaying) {
          await _audio.player.pause();
        } else {
          // Tamamlandıysa başa sar
          if (_audio.player.processingState == ProcessingState.completed) {
            await _audio.player.seek(Duration.zero);
          }
          await _audio.player.play();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isLoaded = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Ses yüklenemedi: ${widget.ilahi.audioPath}"),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  Future<void> _seek(double value) async {
    final target = Duration(milliseconds: value.toInt());
    await _audio.player.seek(target);
  }

  Future<void> _skipBackward() async {
    final target = _position - const Duration(seconds: 10);
    await _audio.player.seek(target < Duration.zero ? Duration.zero : target);
  }

  Future<void> _skipForward() async {
    final target = _position + const Duration(seconds: 10);
    await _audio.player.seek(target > _duration ? _duration : target);
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  void dispose() {
    // Sayfadan çıkınca sesi durdur
    _audio.player.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.ilahi.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
              color: _isFavorite ? Colors.amber.shade600 : null,
            ),
            onPressed: () {
              setState(() => _isFavorite = !_isFavorite);
              widget.onFavoriteToggle(widget.ilahi.id);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // Ses Oynatıcı Kartı
          if (widget.ilahi.hasAudio) ...[
            _AudioPlayerCard(
              ilahi: widget.ilahi,
              isPlaying: _isPlaying,
              isLoading: _isLoading,
              position: _position,
              duration: _duration,
              onTogglePlay: _togglePlay,
              onSeek: _seek,
              onSkipBackward: _skipBackward,
              onSkipForward: _skipForward,
              formatDuration: _formatDuration,
              isDark: isDark,
            ),
            const SizedBox(height: 16),
          ] else ...[
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2A2A1A) : const Color(0xFFFFFDE7),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.amber.shade300.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  Icon(Icons.music_off_rounded, size: 18, color: Colors.amber.shade700),
                  const SizedBox(width: 10),
                  Text(
                    "Bu ilahi için ses dosyası henüz eklenmemiş.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.amber.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Cilt / Yazar bilgisi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark ? const Color(0xFF2A3545) : const Color(0xFFF0F0F0),
              ),
            ),
            child: Row(
              children: [
                _InfoChip(label: "Cilt ${widget.ilahi.ciltNo}", isDark: isDark),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.ilahi.author,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // İlahi sözleri
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: FutureBuilder<String>(
              future: rootBundle.loadString(widget.ilahi.lyricsPath),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Row(
                    children: [
                      const Icon(Icons.error_outline_rounded, color: Colors.red, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Söz dosyası yüklenemedi.",
                          style: TextStyle(color: Colors.red.shade400, fontSize: 14),
                        ),
                      ),
                    ],
                  );
                }
                return Text(
                  snapshot.data ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.8,
                    fontWeight: FontWeight.w400,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MODERN SES OYNATICI KARTI
// ─────────────────────────────────────────────
class _AudioPlayerCard extends StatelessWidget {
  final Ilahi ilahi;
  final bool isPlaying;
  final bool isLoading;
  final Duration position;
  final Duration duration;
  final VoidCallback onTogglePlay;
  final Function(double) onSeek;
  final VoidCallback onSkipBackward;
  final VoidCallback onSkipForward;
  final String Function(Duration) formatDuration;
  final bool isDark;

  const _AudioPlayerCard({
    required this.ilahi,
    required this.isPlaying,
    required this.isLoading,
    required this.position,
    required this.duration,
    required this.onTogglePlay,
    required this.onSeek,
    required this.onSkipBackward,
    required this.onSkipForward,
    required this.formatDuration,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final maxMs = duration.inMilliseconds.toDouble();
    final posMs = position.inMilliseconds.toDouble().clamp(0.0, maxMs > 0 ? maxMs : 1.0);
    final progress = maxMs > 0 ? posMs / maxMs : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF1B3A2A), const Color(0xFF142A1E)]
              : [const Color(0xFFE8F5E9), const Color(0xFFF1F8F1)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          // Başlık + ikon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.music_note_rounded,
                    size: 20, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ilahi.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Cilt ${ilahi.ciltNo}",
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // İlerleme çubuğu
          Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.primary.withOpacity(0.2),
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.primary.withOpacity(0.15),
                ),
                child: Slider(
                  value: posMs,
                  min: 0,
                  max: maxMs > 0 ? maxMs : 1.0,
                  onChanged: maxMs > 0 ? onSeek : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(position),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      formatDuration(duration),
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Kontrol butonları
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 10 sn geri
              _ControlButton(
                icon: Icons.replay_10_rounded,
                size: 28,
                onTap: onSkipBackward,
                isDark: isDark,
              ),
              const SizedBox(width: 16),
              // Oynat / Duraklat
              GestureDetector(
                onTap: isLoading ? null : onTogglePlay,
                child: Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          ),
                        )
                      : Icon(
                          isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                ),
              ),
              const SizedBox(width: 16),
              // 10 sn ileri
              _ControlButton(
                icon: Icons.forward_10_rounded,
                size: 28,
                onTap: onSkipForward,
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;
  final bool isDark;

  const _ControlButton({
    required this.icon,
    required this.size,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(isDark ? 0.15 : 0.1),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(icon, size: size, color: AppColors.primary),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// YARDIMCI WIDGET'LAR
// ─────────────────────────────────────────────
class _InfoChip extends StatelessWidget {
  final String label;
  final bool isDark;

  const _InfoChip({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }
}