# Rin23 2.0 — Android source

แอป Flutter สำหรับ Android แยกจาก Rin23 รุ่นเก่า ใช้ application ID `com.rin23.next`
เวอร์ชัน `2.0.0+1` ภาษาไทยเริ่มต้น ธีมแดง รองรับธีมสว่าง/มืด

## บิลด์ APK

ข้อกำหนดตามโปรเจกต์: Flutter >= 3.47.0 (พร้อม Dart SDK ที่ตรงกัน), JDK 21,
Android SDK Platform 37 และ NDK 29.0.13599879 พร้อม CMake
ให้ติดตั้งส่วนประกอบผ่าน Android Studio/SDK Manager ก่อนบิลด์

จากโฟลเดอร์ที่มี `pubspec.yaml`:

```sh
flutter pub get
flutter gen-l10n
flutter build apk --release --target-platform android-arm64 --dart-define-from-file=.env.json
```

หรือเรียก `bash build-android.sh` บน Linux/macOS และ `build-android.cmd` บน Windows
ผลลัพธ์: `build/app/outputs/flutter-apk/app-release.apk`

ไม่จำเป็นต้องเชื่อม GitHub ซอร์สชุดนี้เน้น Android และไม่ได้แนบชุดไบนารี Windows
คงชื่อแพ็กเกจ Dart ภายใน `alphtoolcoin` เพื่อให้ imports และ native build hooks เดิมตรงกัน
ชื่อที่ผู้ใช้เห็นคือ Rin23

## การตั้งค่า

แนบ `.env.json` ที่มีค่าว่างและ `.env.example.json` ไว้แล้ว จึงไม่ต้องสร้างไฟล์ใหม่เพื่อบิลด์
เมื่อไม่ได้ตั้งค่าเซิร์ฟเวอร์เสริม แอปใช้ฐานข้อมูลใน assets/เครื่อง ไม่มีการอัปเดตฐานข้อมูลออนไลน์
การค้นหารายการยังต้องใช้อินเทอร์เน็ตและบริการต้นทางที่มีอยู่ในโค้ด
รายการที่ไม่มีข้อมูลสำหรับดาวน์โหลดจะยังไม่พร้อมใช้งาน

- `KEYS_URL` และ `KEYS_DECRYPTION_KEY`: ตั้งค่าคู่กัน หากต้องการอัปเดตข้อมูลออนไลน์ ใช้ URL แบบ HTTPS
- `SOCIAL_LINKS_URL`: ไม่ตั้งค่าจะใช้ Rin23 Discord `https://discord.gg/FmUBCt7u5g`
- `ANNOUNCEMENTS_URL`: ฟีดข่าวสารของผู้ดูแล
- `UPDATE_URL`: ข้อมูลอัปเดตแอปของผู้ดูแล
- `UPLOAD_KEYS_URL`: ปิดเมื่อเว้นว่าง หากเปิดจะใช้เส้นทางอัปโหลดข้อมูลเดิมของโปรเจกต์

ไม่ได้ตั้งหรือสร้างเซิร์ฟเวอร์เหล่านี้ให้ และไม่ได้เพิ่มระบบรับเงิน/บริจาคในรุ่นนี้
ค่าที่ฝังด้วย dart-define เป็นข้อมูลในแอป ไม่ควรใช้เก็บรหัสลับของเซิร์ฟเวอร์

## การลงนาม

Gradle ใช้ `android/key.properties` เมื่อมีไฟล์ หากไม่มีจะใช้ debug keystore ตามโครงสร้างเดิม
สำหรับ APK ที่จะแจกและอัปเดตต่อ ให้สร้าง keystore ของตัวเองและเก็บไว้ใช้ต่อเนื่อง
ตัวอย่าง `android/key.properties.example` มีให้แล้ว ไม่แนบกุญแจส่วนตัวในซอร์ส

## สิ่งที่แก้ในชุดนี้

- แก้ MethodChannel ของ Dart ให้ตรงกับ Kotlin ทุกช่อง: import, storage, download, deeplink
- แก้ metadata ไอคอนแจ้งเตือนให้ตรงกับ AndroidManifest
- แก้พาธ Dart/Kotlin/MediaStore ให้บันทึกใน `Download/rin23`
- เปลี่ยนไอคอนเป็นกระทิงแดงสองเขา มี SVG ต้นฉบับให้แก้ไขต่อ
- เปลี่ยนหน้าเริ่มต้น/หัวแอป/เวอร์ชัน/ลิงก์ชุมชน/เครดิตเป็น Rin23 และเก็บเครดิตต้นฉบับ
- เพิ่มดึงลงรีเฟรชรายการ ป้องกันผลค้นหาเก่าทับคำค้นล่าสุด แก้การเรียงในหน้าค้นพบ
- แก้ deep link ให้ค้นหาในหมวดทั้งหมด และป้องกัน grid จำนวนคอลัมน์เป็นศูนย์
- เพิ่มเวลาสิ้นสุดคำขอเครือข่ายและหน้าลองใหม่ ลดกรณีรอไม่สิ้นสุด
- ข้ามบริการเสริมที่ไม่ได้ตั้งค่า และปิด Android backup
- ตัด workflow เผยแพร่/มิเรอร์ของต้นฉบับออกจากซอร์สส่งมอบ

## สถานะการตรวจ

ตรวจโค้ด ช่องเชื่อมต่อ native, XML/JSON/YAML, assets และโครงสร้าง ZIP ในรอบนี้
ไม่ได้รัน Flutter analyzer, ชุดทดสอบ หรือบิลด์ APK ตามคำขอให้ส่งซอร์ส
ยังไม่ยืนยันการทำงานบนมือถือจริงหรือความพร้อมของบริการภายนอก

## ต้นฉบับ

พัฒนาต่อยอดจาก ToolCoin_Dart / ToolcoinTeam ใน ZIP ที่ผู้ใช้ให้มา
เก็บเอกสารต้นฉบับไว้ใน `UPSTREAM_README.md` และประวัติเดิมใน `UPSTREAM_CHANGELOG_SOURCE.txt`
คงประกาศและใบอนุญาตของ dependency ที่แนบมาไว้ตามเดิม
Rin23 ไม่เกี่ยวข้องกับ Mojang หรือ Microsoft
