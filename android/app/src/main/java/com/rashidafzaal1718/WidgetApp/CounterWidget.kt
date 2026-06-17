package com.rashidafzaal1718.WidgetApp

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import java.io.File

class CounterWidget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    companion object {
        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val count = readCount(context)
            val views = RemoteViews(context.packageName, R.layout.counter_widget)
            views.setTextViewText(R.id.counter_value, count.toString())
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }

        private fun readCount(context: Context): Int {
            return try {
                val file = File(context.filesDir, "count.txt")
                if (file.exists()) file.readText().trim().toInt() else 0
            } catch (e: Exception) {
                0
            }
        }
    }
}