---
name: building-react-native-apps
description: Kỹ năng chuyên sâu về phát triển ứng dụng di động đa nền tảng bằng React Native và Redux Toolkit.
---

# Kỹ năng Phát triển Ứng dụng React Native (React Native Development Skills)

Skill này cung cấp các nguyên tắc kiến trúc, quy chuẩn viết code và giải pháp state management chuẩn mực khi phát triển ứng dụng React Native cho nền tảng iOS và Android. Đặc biệt chú trọng vào hiệu năng, kiến trúc Clean/Feature-based và tối ưu hóa quản lý trạng thái.

## Khi nào sử dụng (When to use)
- Khi tạo mới một tính năng hoặc màn hình trong ứng dụng React Native.
- Khi refactor các component cồng kềnh (bloated components).
- Khi xử lý giao tiếp API (REST/WebSocket/STOMP) và quản lý trạng thái toàn cục (Redux Toolkit).
- Khi thiết lập cấu trúc điều hướng (Navigation).

## Nguyên tắc cốt lõi (Core Principles)
1.  **Phân tách Mối quan tâm (Separation of Concerns):** Component chỉ làm nhiệm vụ hiển thị (UI). Mọi logic nghiệp vụ (business logic), tính toán, và gọi mạng phải được tách ra Custom Hooks, Redux Thunks, hoặc Services.
2.  **Kiến trúc theo Tính năng (Feature-based Architecture):** Tổ chức mã nguồn dựa trên Tính năng (Domain/Feature) thay vì Loại tệp (Type).
3.  **An toàn Kiểu (Type Safety):** Sử dụng TypeScript một cách chặt chẽ. Tránh sử dụng `any`, định nghĩa rõ ràng DTOs (Data Transfer Objects) và Entities.
4.  **Tối ưu Hiệu năng (Performance Optimization):** Sử dụng `useMemo`, `useCallback` đúng lúc. Tránh re-renders không cần thiết, đặc biệt trên các danh sách (FlatList/FlashList) và Bản đồ (Maps).

## Hướng dẫn chi tiết (Detailed Rules)
Vui lòng tham khảo và tuân thủ tuyệt đối các quy tắc trong các tệp con sau đây trước khi viết bất kỳ dòng code nào:

1.  [Kiến trúc dự án (Architecture)](rules/architecture.md) - Cách cấu trúc file và thư mục.
2.  [Quản lý Trạng thái (State Management)](rules/state-management.md) - Hướng dẫn dùng Redux Toolkit và Middleware.
3.  [Giao tiếp Mạng (Networking)](rules/networking.md) - Cấu hình Axios, Interceptors, Socket.
4.  [Thiết kế UI Components (UI Components)](rules/ui-components.md) - Cách phân chia Smart/Dumb Components, styling.

## Ví dụ tham khảo (References)
- Tham khảo `shipper_app2` (Redux Middleware implementation).
- Các dự án áp dụng Clean Architecture kết hợp Feature-Sliced Design.
