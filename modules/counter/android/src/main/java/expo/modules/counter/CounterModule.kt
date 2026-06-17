package expo.modules.counter

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition
import java.io.File

class CounterModule : Module() {
  private val context: Context
    get() = appContext.reactContext ?: throw Exception("React context is not available")

  override fun definition() = ModuleDefinition {
    Name("Counter")

    Events("onCountChange")

    Function("getCount") {
      readCount()
    }

    Function("setCount") { value: Int ->
      writeCount(value)
      sendEvent("onCountChange", mapOf("count" to value))
      updateWidgets()
    }
  }

  private fun countFile(): File {
    return File(context.filesDir, "count.txt")
  }

  private fun readCount(): Int {
    return try {
      val file = countFile()
      if (file.exists()) file.readText().trim().toInt() else 0
    } catch (e: Exception) {
      0
    }
  }

  private fun writeCount(value: Int) {
    countFile().writeText(value.toString())
  }

  private fun updateWidgets() {
    val manager = AppWidgetManager.getInstance(context)
    val componentName = ComponentName(context, "com.rashidafzaal1718.WidgetApp.CounterWidget")
    val ids = manager.getAppWidgetIds(componentName)

    val intent = android.content.Intent(context, Class.forName("com.rashidafzaal1718.WidgetApp.CounterWidget"))
    intent.action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
    intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids)
    context.sendBroadcast(intent)
  }
}