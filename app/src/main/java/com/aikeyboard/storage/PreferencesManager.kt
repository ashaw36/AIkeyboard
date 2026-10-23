package com.aikeyboard.storage

import android.content.Context
import android.content.SharedPreferences
import com.aikeyboard.ai.models.AIConfig
import com.aikeyboard.ai.models.ServiceType

/**
 * 配置存储管理器
 */
class PreferencesManager(context: Context) {

    private val prefs: SharedPreferences = context.getSharedPreferences(
        "aikeyboard_prefs",
        Context.MODE_PRIVATE
    )

    companion object {
        // AI服务配置
        private const val KEY_SERVICE_TYPE = "service_type"
        private const val KEY_API_KEY = "api_key"
        private const val KEY_BASE_URL = "base_url"
        private const val KEY_MODEL = "model"
        private const val KEY_TEMPERATURE = "temperature"
        private const val KEY_MAX_TOKENS = "max_tokens"

        // 键盘设置
        private const val KEY_THEME = "theme"
        private const val KEY_VIBRATE = "vibrate"
        private const val KEY_SOUND = "sound"
        private const val KEY_HEIGHT = "keyboard_height"

        // AI功能开关
        private const val KEY_ENABLE_REWRITE = "enable_rewrite"
        private const val KEY_ENABLE_CONTINUE = "enable_continue"
        private const val KEY_AUTO_SUGGEST = "auto_suggest"

        // 主题值
        const val THEME_LIGHT = 0
        const val THEME_DARK = 1
        const val THEME_SYSTEM = 2
    }

    // ========== AI服务配置 ==========

    fun getAIConfig(): AIConfig {
        val serviceTypeStr = prefs.getString(KEY_SERVICE_TYPE, ServiceType.DEEPSEEK.name) ?: ServiceType.DEEPSEEK.name
        return AIConfig(
            serviceType = ServiceType.valueOf(serviceTypeStr),
            apiKey = prefs.getString(KEY_API_KEY, "") ?: "",
            baseUrl = prefs.getString(KEY_BASE_URL, "https://api.deepseek.com") ?: "https://api.deepseek.com",
            model = prefs.getString(KEY_MODEL, "deepseek-chat") ?: "deepseek-chat",
            temperature = prefs.getFloat(KEY_TEMPERATURE, 0.7f),
            maxTokens = prefs.getInt(KEY_MAX_TOKENS, 500)
        )
    }

    fun saveAIConfig(config: AIConfig) {
        prefs.edit().apply {
            putString(KEY_SERVICE_TYPE, config.serviceType.name)
            putString(KEY_API_KEY, config.apiKey)
            putString(KEY_BASE_URL, config.baseUrl)
            putString(KEY_MODEL, config.model)
            putFloat(KEY_TEMPERATURE, config.temperature)
            putInt(KEY_MAX_TOKENS, config.maxTokens)
            apply()
        }
    }

    var apiKey: String
        get() = prefs.getString(KEY_API_KEY, "") ?: ""
        set(value) = prefs.edit().putString(KEY_API_KEY, value).apply()

    var baseUrl: String
        get() = prefs.getString(KEY_BASE_URL, "https://api.deepseek.com") ?: "https://api.deepseek.com"
        set(value) = prefs.edit().putString(KEY_BASE_URL, value).apply()

    // ========== 键盘设置 ==========

    var theme: Int
        get() = prefs.getInt(KEY_THEME, THEME_SYSTEM)
        set(value) = prefs.edit().putInt(KEY_THEME, value).apply()

    var vibrateEnabled: Boolean
        get() = prefs.getBoolean(KEY_VIBRATE, true)
        set(value) = prefs.edit().putBoolean(KEY_VIBRATE, value).apply()

    var soundEnabled: Boolean
        get() = prefs.getBoolean(KEY_SOUND, false)
        set(value) = prefs.edit().putBoolean(KEY_SOUND, value).apply()

    var keyboardHeight: Int
        get() = prefs.getInt(KEY_HEIGHT, 100)  // 默认100%
        set(value) = prefs.edit().putInt(KEY_HEIGHT, value).apply()

    // ========== AI功能开关 ==========

    var enableRewrite: Boolean
        get() = prefs.getBoolean(KEY_ENABLE_REWRITE, true)
        set(value) = prefs.edit().putBoolean(KEY_ENABLE_REWRITE, value).apply()

    var enableContinue: Boolean
        get() = prefs.getBoolean(KEY_ENABLE_CONTINUE, true)
        set(value) = prefs.edit().putBoolean(KEY_ENABLE_CONTINUE, value).apply()

    var autoSuggest: Boolean
        get() = prefs.getBoolean(KEY_AUTO_SUGGEST, false)
        set(value) = prefs.edit().putBoolean(KEY_AUTO_SUGGEST, value).apply()
}
