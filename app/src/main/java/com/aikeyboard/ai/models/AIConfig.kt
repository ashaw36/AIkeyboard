package com.aikeyboard.ai.models

/**
 * AI服务类型
 */
enum class ServiceType {
    DEEPSEEK,
    CUSTOM
}

/**
 * AI配置
 */
data class AIConfig(
    val serviceType: ServiceType = ServiceType.DEEPSEEK,
    val apiKey: String = "",
    val baseUrl: String = "https://api.deepseek.com",
    val model: String = "deepseek-chat",
    val temperature: Float = 0.7f,
    val maxTokens: Int = 500
)

/**
 * 改写风格
 */
enum class RewriteStyle(val prompt: String) {
    REWRITE("请改写以下文本，保持原意但使用不同的表达方式：\n\n"),
    POLISH("请润色以下文本，使其更加流畅自然：\n\n"),
    FORMAL("请将以下文本改写为正式的表达方式：\n\n"),
    SIMPLIFY("请精简以下文本，去除冗余内容：\n\n"),
    TRANSLATE_EN("Please translate the following text to English:\n\n"),
    TRANSLATE_ZH("请将以下文本翻译成中文：\n\n")
}

/**
 * AI请求
 */
data class AIRequest(
    val model: String,
    val messages: List<Message>,
    val temperature: Float = 0.7f,
    val max_tokens: Int = 500
)

data class Message(
    val role: String,
    val content: String
)

/**
 * AI响应
 */
data class AIResponse(
    val id: String,
    val choices: List<Choice>,
    val usage: Usage?
)

data class Choice(
    val message: Message,
    val finish_reason: String
)

data class Usage(
    val prompt_tokens: Int,
    val completion_tokens: Int,
    val total_tokens: Int
)

/**
 * 错误响应
 */
data class AIError(
    val error: ErrorDetail
)

data class ErrorDetail(
    val message: String,
    val type: String,
    val code: String?
)
