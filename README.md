
# Driver Task

## Uygulamanın Amacı

Driver Task, kuryeler/şoförler için görev yönetimi sağlayan bir mobil uygulamadır. Kullanıcılar, kendilerine atanan teslimat görevlerini listeleyebilir, detaylarını görebilir, harita üzerinde rota takibi yapabilir ve teslimat süreçlerini yönetebilirler. Uygulama, görevlerin başlatılması, başarısız olarak işaretlenmesi ve paketlerin barkod ile taranması gibi işlevler sunar.

## Kullanılan Teknolojiler ve Paketler

- **Flutter**: Uygulamanın temel çatısı
- **State Management**: `bloc`, `flutter_bloc`
- **Network**: `dio`, `equatable`
- **UI**: `flutter_screenutil`, `lottie`, `flutter_svg`, `shimmer`, `flutter_staggered_animations`
- **Localization**: `easy_localization`, `intl`, `flutter_localizations`
- **Router**: `go_router`
- **Map**: `google_maps_flutter`, `geolocator`, `geocoding`, `google_polyline_algorithm`
- **Dependency Injection**: `get_it`
- **Barcode/QR Okuyucu**: `mobile_scanner`
- **Çevre Değişkenleri**: `flutter_dotenv`
- **Error Handling**: `either_dart`

## Ana Özellikler

- Görev listesi ve detayları
- Görev başlatma, başarısız işaretleme, paket tarama
- Google Maps ile rota ve konum takibi
- Barkod/QR kod ile paket doğrulama
- Çoklu dil desteği (TR, EN, RU, AZ)
- Modern ve animasyonlu kullanıcı arayüzü

## Proje Mimarisi

- **Feature-based** dosya yapısı (features, core, shared)
- Bloc tabanlı durum yönetimi
- Servis ve repository katmanları ile ayrık iş mantığı
- Modüler ve ölçeklenebilir yapı

## Ekran Görüntüsü / Tanıtım Videosu

Aşağıdaki video uygulamanın genel işleyişini göstermektedir:

[![Uygulama Tanıtım Videosu](https://img.youtube.com/vi/placeholder/0.jpg)](assets/videos/app_review.mp4)

> Videoyu izlemek için yukarıdaki görsele tıklayabilir veya `assets/videos/app_review.mp4` dosyasını açabilirsiniz.

## Kurulum ve Çalıştırma

1. Bağımlılıkları yükleyin:
	```sh
	flutter pub get
	```
2. Çevre dosyalarını (.env) ve gerekli API anahtarlarını ekleyin.
3. Uygulamayı başlatın:
	```sh
	flutter run
	```

## Lisans

MIT
