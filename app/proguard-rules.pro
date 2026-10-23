# Keep line numbers for debugging
-keepattributes SourceFile,LineNumberTable

# Keep OkHttp classes
-dontwarn okhttp3.**
-dontwarn okio.**
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }

# Keep Gson classes
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep AI models
-keep class com.aikeyboard.ai.models.** { *; }

# Keep InputMethodService
-keep class com.aikeyboard.ime.** { *; }
