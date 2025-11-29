# Cách bật bàn phím trên iOS Simulator

## Vấn đề

Bàn phím không hiện khi tap vào TextField trên iOS Simulator.

## Giải pháp

### Cách 1: Bật Software Keyboard trong Simulator (Khuyến nghị)

1. Mở iOS Simulator
2. Vào menu: **I/O → Keyboard → Toggle Software Keyboard**
   - Hoặc nhấn phím tắt: **⌘K** (Command + K)
3. Bàn phím sẽ hiện lên khi tap vào TextField

### Cách 2: Sử dụng Hardware Keyboard

1. Vào menu: **I/O → Keyboard → Connect Hardware Keyboard**
2. Bỏ chọn (uncheck) để dùng Software Keyboard
3. Hoặc nhấn: **⌘⇧K** (Command + Shift + K)

### Cách 3: Kiểm tra Settings trong Simulator

1. Mở **Settings** app trong Simulator
2. Vào **General → Keyboard**
3. Đảm bảo các tùy chọn keyboard đã được bật

## Lưu ý

- Trên iOS Simulator, Software Keyboard mặc định có thể bị tắt
- Phím tắt **⌘K** là cách nhanh nhất để toggle keyboard
- Nếu vẫn không hiện, thử restart Simulator

## Test

Sau khi bật keyboard:

1. Tap vào bất kỳ TextField nào trong app
2. Bàn phím sẽ tự động hiện lên
3. Có thể nhập text bình thường
