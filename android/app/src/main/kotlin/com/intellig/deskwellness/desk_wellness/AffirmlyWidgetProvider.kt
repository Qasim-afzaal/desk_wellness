package com.intellig.deskwellness.desk_wellness

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Color
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class AffirmlyWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.affirmly_widget).apply {
                val text = widgetData.getString("affirmation_text", "I am enough.")
                val background = widgetData.getString("background_hex", "#17372A")
                val textColor = widgetData.getString("text_color_hex", "#F7F3E8")
                val accent = widgetData.getString("accent_hex", "#F2C96D")
                val showBrand = widgetData.getBoolean("show_brand", true)

                setTextViewText(R.id.widget_text, text)
                setInt(R.id.widget_container, "setBackgroundColor", parseColor(background, "#17372A"))
                setTextColor(R.id.widget_text, parseColor(textColor, "#F7F3E8"))
                setTextColor(R.id.widget_brand_text, parseColor(textColor, "#F7F3E8"))
                setTextColor(R.id.widget_accent, parseColor(accent, "#F2C96D"))
                setViewVisibility(R.id.widget_brand, if (showBrand) View.VISIBLE else View.GONE)

                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                )
                setOnClickPendingIntent(R.id.widget_container, pendingIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    private fun parseColor(value: String?, fallback: String): Int =
        try {
            Color.parseColor(value ?: fallback)
        } catch (_: IllegalArgumentException) {
            Color.parseColor(fallback)
        }
}
