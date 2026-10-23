package com.aikeyboard.ai

import com.aikeyboard.ai.models.*
import com.google.gson.Gson
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import java.io.IOException
import java.util.concurrent.TimeUnit

class DeepSeekClient(
    private val apiKey: String,
    private val baseUrl: String = "https://api.deepseek.com"
) {
    private val client = OkHttpClient.Builder()
        .connectTimeout(30, TimeUnit.SECONDS)
        .readTimeout(30, TimeUnit.SECONDS)
        .build()

    private val gson = Gson()
    private val mediaType = "application/json".toMediaType()

    suspend fun rewrite(text: String, style: RewriteStyle, model: String = "deepseek-chat"): Result<String> {
        return chat(style.prompt + text, model)
    }

    suspend fun complete(context: String, model: String = "deepseek-chat"): Result<String> {
        return chat("请根据上下文续写：\n\n$context", model)
    }

    private suspend fun chat(prompt: String, model: String): Result<String> = withContext(Dispatchers.IO) {
        try {
            if (apiKey.isBlank()) {
                return@withContext Result.failure(Exception("API Key未配置"))
            }

            val request = AIRequest(
                model = model,
                messages = listOf(Message(role = "user", content = prompt)),
                temperature = 0.7f,
                max_tokens = 500
            )

            val json = gson.toJson(request)
            val body = json.toRequestBody(mediaType)

            val httpRequest = Request.Builder()
                .url("$baseUrl/v1/chat/completions")
                .addHeader("Authorization", "Bearer $apiKey")
                .post(body)
                .build()

            val response = client.newCall(httpRequest).execute()
            val responseBody = response.body?.string()

            if (!response.isSuccessful) {
                val errorMsg = try {
                    gson.fromJson(responseBody, AIError::class.java).error.message
                } catch (e: Exception) {
                    "HTTP ${response.code}"
                }
                return@withContext Result.failure(IOException(errorMsg))
            }

            val aiResponse = gson.fromJson(responseBody, AIResponse::class.java)
            val content = aiResponse.choices.firstOrNull()?.message?.content
                ?: return@withContext Result.failure(IOException("无响应内容"))

            Result.success(content.trim())
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    suspend fun testConnection(): Result<Boolean> {
        val result = chat("Hello", "deepseek-chat")
        return if (result.isSuccess) Result.success(true)
        else Result.failure(result.exceptionOrNull() ?: Exception("测试失败"))
    }
}
