package com.aikeyboard.ime

import android.inputmethodservice.InputMethodService
import android.inputmethodservice.Keyboard
import android.inputmethodservice.KeyboardView
import android.view.View
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputConnection
import com.aikeyboard.R
import com.aikeyboard.ai.AIServiceManager
import com.aikeyboard.ai.models.RewriteStyle
import com.aikeyboard.storage.PreferencesManager
import kotlinx.coroutines.*

class AIKeyboardService : InputMethodService(), KeyboardView.OnKeyboardActionListener {

    private var keyboardView: KeyboardView? = null
    private var keyboard: Keyboard? = null
    private var prefsManager: PreferencesManager? = null
    private var aiService: AIServiceManager? = null
    private var serviceScope = CoroutineScope(Dispatchers.Main + SupervisorJob())

    private var caps = false
    private var lastText = ""

    override fun onCreateInputView(): View {
        prefsManager = PreferencesManager(this)
        
        val config = prefsManager!!.getAIConfig()
        aiService = AIServiceManager(config)
        aiService?.initialize()

        keyboardView = layoutInflater.inflate(R.layout.keyboard_view, null) as KeyboardView
        keyboard = Keyboard(this, R.xml.qwerty)
        keyboardView?.apply {
            this.keyboard = this@AIKeyboardService.keyboard
            setOnKeyboardActionListener(this@AIKeyboardService)
            isPreviewEnabled = false
        }

        return keyboardView!!
    }

    override fun onKey(primaryCode: Int, keyCodes: IntArray?) {
        val ic = currentInputConnection ?: return
        
        when (primaryCode) {
            Keyboard.KEYCODE_DELETE -> {
                ic.deleteSurroundingText(1, 0)
            }
            Keyboard.KEYCODE_SHIFT -> {
                caps = !caps
                keyboard?.isShifted = caps
                keyboardView?.invalidateAllKeys()
            }
            Keyboard.KEYCODE_DONE -> {
                ic.sendKeyEvent(android.view.KeyEvent(
                    android.view.KeyEvent.ACTION_DOWN,
                    android.view.KeyEvent.KEYCODE_ENTER
                ))
            }
            -10 -> { // AI按钮
                showAIMenu()
            }
            else -> {
                var code = primaryCode.toChar()
                if (Character.isLetter(code) && caps) {
                    code = Character.toUpperCase(code)
                }
                ic.commitText(code.toString(), 1)
            }
        }
    }

    private fun showAIMenu() {
        // TODO: 显示AI功能菜单（改写/续写）
    }

    private fun getSelectedText(): String? {
        val ic = currentInputConnection ?: return null
        val selectedText = ic.getSelectedText(0)
        return if (selectedText.isNullOrBlank()) null else selectedText.toString()
    }

    private fun rewriteText(style: RewriteStyle) {
        val selectedText = getSelectedText()
        if (selectedText.isNullOrBlank()) {
            return
        }

        serviceScope.launch {
            val result = aiService?.rewrite(selectedText, style)
            result?.onSuccess { rewritten ->
                currentInputConnection?.apply {
                    finishComposingText()
                    deleteSurroundingText(selectedText.length, 0)
                    commitText(rewritten, 1)
                }
            }
        }
    }

    override fun onPress(primaryCode: Int) {}
    override fun onRelease(primaryCode: Int) {}
    override fun onText(text: CharSequence?) {}
    override fun swipeLeft() {}
    override fun swipeRight() {}
    override fun swipeDown() {}
    override fun swipeUp() {}

    override fun onDestroy() {
        super.onDestroy()
        serviceScope.cancel()
    }
}
