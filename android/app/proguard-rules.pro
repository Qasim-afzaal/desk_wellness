# Flutter / R8 keep rules — release minify strips WorkManager/Room without these.

# WorkManager (home_widget / flutter_local_notifications)
-keep class androidx.work.** { *; }
-keep interface androidx.work.** { *; }
-dontwarn androidx.work.**
-keep class * extends androidx.work.Worker
-keep class * extends androidx.work.ListenableWorker {
    public <init>(android.content.Context,androidx.work.WorkerParameters);
}

# Room (WorkDatabase)
-keep class * extends androidx.room.RoomDatabase { *; }
-keep @androidx.room.Entity class * { *; }
-keep @androidx.room.Dao class * { *; }
-dontwarn androidx.room.paging.**

# flutter_local_notifications
-keep class com.dexterous.** { *; }
-dontwarn com.dexterous.**

# home_widget
-keep class es.antonborri.home_widget.** { *; }
-keep class com.intellig.deskwellness.desk_wellness.AffirmlyWidgetProvider { *; }

# Keep Startup / Initializers
-keep class androidx.startup.** { *; }
-keep class * extends androidx.startup.Initializer { *; }
