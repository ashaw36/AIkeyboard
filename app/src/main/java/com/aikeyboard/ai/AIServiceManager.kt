package com.aikeyboard.ai

import com.aikeyboard.ai.models.AIConfig
import com.aikeyboard.ai.models.RewriteStyle

class AIServiceManager(private val config: AIConfig) {
    private var client: DeepSeekClient? = null

    fun initialize() {
        client = DeepSeekClient(
            apiKey = config.apiKey,
            baseUrl = config.baseUrl
        )
    }

    suspend fun rewrite(text: String, style: RewriteStyle): Result<String> {
        val c = client ?: return Result.failure(Exception("AI服务未初始化"))
        return c.rewrite(text, style, config.model)
    }

    suspend fun complete(context: String): Result<String> {
        val c = client ?: return Result.failure(Exception("AI服务未初始化"))
        return c.complete(context, config.model)
    }

    suspend fun testConnection(): Result<Boolean> {
        val c = client ?: return Result.failure(Exception("AI服务未初始化"))
        return c.testConnection()
    }
}
