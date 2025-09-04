class Validators {
  static String? validateUserProfile({
    required String email,
    String? fullName,
    String? phone,
    DateTime? dob,
  }) {
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (!isEmailValid(email)) {
      return 'Please enter a valid email address';
    }
    if (fullName != null && fullName.length < 2) {
      return 'Full name must be at least 2 characters';
    }
    if (phone != null && phone.isNotEmpty && !isPhoneValid(phone)) {
      return 'Please enter a valid phone number';
    }
    if (dob != null && dob.isAfter(DateTime.now())) {
      return 'Date of birth cannot be in the future';
    }
    return null;
  }

  static bool isPhoneValid(String phone) {
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length >= 10 && digitsOnly.length <= 15;
  }
  static bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return password.length >= 6;
  }

  static String? validateImageFile(String imagePath) {
    // Check file extension
    final allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
    final extension = imagePath.toLowerCase().split('.').last;
    
    if (!allowedExtensions.any((ext) => ext.contains(extension))) {
      return 'Please select a valid image file (JPG, PNG, GIF, WebP)';
    }

    return null;
  }
}