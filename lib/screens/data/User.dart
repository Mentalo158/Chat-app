class User {
  final String imagePathProfile;
  final String imagePathHeader;
  final String imagePath;
  final String name;
  final String email;
  final String description;
  final String isDarkMode;

  const User(
    this.imagePath,
    this.name,
    this.email,
    this.description,
    this.isDarkMode,
    this.imagePathProfile,
    this.imagePathHeader,
  );
}
