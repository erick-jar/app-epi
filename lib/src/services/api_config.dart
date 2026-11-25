class ApiConfig {
// Pode ser trocada na hora do build com --dart-define=API_URL=...
static const String baseUrl = String.fromEnvironment(
'API_URL',
defaultValue: 'https://https://api-epi-erick.onrender.com',
);
}