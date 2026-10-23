package com.aikeyboard.ui.settings

import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import android.view.inputmethod.InputMethodManager
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import com.aikeyboard.R
import com.aikeyboard.ai.AIServiceManager
import com.aikeyboard.storage.PreferencesManager
import kotlinx.coroutines.*

class SettingsActivity : AppCompatActivity() {

    private lateinit var prefsManager: PreferencesManager
    private val scope = CoroutineScope(Dispatchers.Main + SupervisorJob())

    private lateinit var apiKeyEdit: EditText
    private lateinit var baseUrlEdit: EditText
    private lateinit var modelEdit: EditText
    private lateinit var testButton: Button
    private lateinit var enableKeyboardButton: Button
    private lateinit var statusText: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_settings)

        prefsManager = PreferencesManager(this)
        
        initViews()
        loadSettings()
        setupListeners()
        checkKeyboardEnabled()
    }

    private fun initViews() {
        apiKeyEdit = findViewById(R.id.apiKeyEdit)
        baseUrlEdit = findViewById(R.id.baseUrlEdit)
        modelEdit = findViewById(R.id.modelEdit)
        testButton = findViewById(R.id.testButton)
        enableKeyboardButton = findViewById(R.id.enableKeyboardButton)
        statusText = findViewById(R.id.statusText)
    }

    private fun loadSettings() {
        val config = prefsManager.getAIConfig()
        apiKeyEdit.setText(config.apiKey)
        baseUrlEdit.setText(config.baseUrl)
        modelEdit.setText(config.model)
    }

    private fun setupListeners() {
        testButton.setOnClickListener {
            testConnection()
        }

        enableKeyboardButton.setOnClickListener {
            startActivity(Intent(Settings.ACTION_INPUT_METHOD_SETTINGS))
        }

        // 保存设置（失去焦点时）
        apiKeyEdit.setOnFocusChangeListener { _, hasFocus ->
            if (!hasFocus) saveSettings()
        }
        baseUrlEdit.setOnFocusChangeListener { _, hasFocus ->
            if (!hasFocus) saveSettings()
        }
        modelEdit.setOnFocusChangeListener { _, hasFocus ->
            if (!hasFocus) saveSettings()
        }
    }

    private fun saveSettings() {
        val config = prefsManager.getAIConfig().copy(
            apiKey = apiKeyEdit.text.toString(),
            baseUrl = baseUrlEdit.text.toString(),
            model = modelEdit.text.toString()
        )
        prefsManager.saveAIConfig(config)
        Toast.makeText(this, R.string.msg_save_success, Toast.LENGTH_SHORT).show()
    }

    private fun testConnection() {
        val apiKey = apiKeyEdit.text.toString()
        val baseUrl = baseUrlEdit.text.toString()

        if (apiKey.isBlank()) {
            Toast.makeText(this, "请先填写API Key", Toast.LENGTH_SHORT).show()
            return
        }

        testButton.isEnabled = false
        testButton.text = "测试中..."

        val config = prefsManager.getAIConfig().copy(
            apiKey = apiKey,
            baseUrl = baseUrl
        )

        val aiService = AIServiceManager(config)
        aiService.initialize()

        scope.launch {
            val result = aiService.testConnection()
            
            testButton.isEnabled = true
            testButton.text = "测试连接"

            result.onSuccess {
                Toast.makeText(
                    this@SettingsActivity,
                    R.string.msg_api_test_success,
                    Toast.LENGTH_SHORT
                ).show()
                statusText.text = "✓ API连接正常"
                statusText.setTextColor(getColor(R.color.ai_success))
            }.onFailure { e ->
                val msg = getString(R.string.msg_api_test_failed, e.message)
                Toast.makeText(this@SettingsActivity, msg, Toast.LENGTH_LONG).show()
                statusText.text = "✗ ${e.message}"
                statusText.setTextColor(getColor(R.color.ai_error))
            }
        }
    }

    private fun checkKeyboardEnabled() {
        val imm = getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager
        val enabledIMEs = imm.enabledInputMethodList
        val isEnabled = enabledIMEs.any { it.packageName == packageName }

        if (isEnabled) {
            enableKeyboardButton.text = "已启用 ✓"
            enableKeyboardButton.isEnabled = false
        } else {
            enableKeyboardButton.text = "点击启用键盘"
        }
    }

    override fun onResume() {
        super.onResume()
        checkKeyboardEnabled()
    }

    override fun onPause() {
        super.onPause()
        saveSettings()
    }

    override fun onDestroy() {
        super.onDestroy()
        scope.cancel()
    }
}
