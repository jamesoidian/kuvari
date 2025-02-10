# Flutterin tarvitsemat säännöt                                                                                                            
-keep class io.flutter.app.** { *; }                                                                                                       
-keep class io.flutter.plugin.** { *; }                                                                                                    
-keep class io.flutter.util.** { *; }                                                                                                      
-keep class io.flutter.view.** { *; }                                                                                                      
-keep class io.flutter.** { *; }                                                                                                           

-keep class com.google.android.play.** { *; }  
-keep class com.google.android.gms.tasks.** { *; }  
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
-keep class io.flutter.embedding.engine.FlutterJNI { *; }    
-keep class io.github.jamesoidian.kuvari.KuvariApp { *; }

# NDK debug symbols
-keepattributes LineNumberTable,SourceFile
-renamesourcefileattribute SourceFile
                                                       
