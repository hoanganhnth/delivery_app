/// Agora RTC Engine Configuration
class AgoraConfig {
  /// Agora App ID
  /// Get this from https://console.agora.io/
  static const String appId = 'YOUR_AGORA_APP_ID';
  
  /// Agora App Certificate (for token generation)
  static const String appCertificate = 'YOUR_AGORA_APP_CERTIFICATE';
  
  /// Token expiration time in seconds (24 hours)
  static const int tokenExpirationTimeInSeconds = 86400;
  
  /// Channel name prefix
  static const String channelPrefix = 'delivery_livestream_';
  
  /// Default video encoding configs
  static const int videoWidth = 1280;
  static const int videoHeight = 720;
  static const int videoFrameRate = 30;
  static const int videoBitrate = 2000; // kbps
  
  /// Audio encoding configs
  static const int audioSampleRate = 48000;
  static const int audioBitrate = 128; // kbps
  
  /// Whether to enable dual stream mode
  static const bool enableDualStream = true;
  
  /// Whether to enable encryption
  static const bool enableEncryption = false;
  
  /// Encryption key (if enableEncryption is true)
  static const String encryptionKey = 'YOUR_ENCRYPTION_KEY';
  
  /// Default client role for viewers
  static const bool defaultClientRoleAudience = true;
}
