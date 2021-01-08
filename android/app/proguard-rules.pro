# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /home/pablo/Android/Sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Retrolambda
#-dontwarn java.lang.invoke.*
#-dontwarn **$$Lambda$*
#
## Moshi
#-dontwarn okio.**
#-dontwarn javax.annotation.Nullable
#-dontwarn javax.annotation.ParametersAreNonnullByDefault
#-keepclasseswithmembers class * {
#    @com.squareup.moshi.* <methods>;
#}
#
#-dontwarn com.google.android.libraries.places.**
#
#-keep class org.apache.log4j.*{ *; }
#-keepclassmembers class org.apache.log4j.*{ *; }
#-dontwarn org.apache.log4j.**
#
#-dontwarn com.trello.**
#-dontwarn retrofit2.**
#
#
#-keep class za.co.nedbank.nid_sdk.main.core.controls.** { *; }
#
## crashlytics
#-keepattributes *Annotation*
#-keepattributes SourceFile,LineNumberTable
#-keep public class * extends java.lang.Exception
#-keep class com.crashlytics.** { *; }
#-dontwarn com.crashlytics.**
#-dontwarn com.android.installreferrer.**
#
#-dontwarn okhttp3.**
#-dontwarn javax.annotation.**
#-dontwarn org.conscrypt.**
#
## Eventbus
#-keepattributes *Annotation*
#-keepclassmembers class * {
#    @org.greenrobot.eventbus.Subscribe <methods>;
#}
#
#-keep class com.adobe.mobile.** { *; }
#-dontwarn com.google.android.gms.wearable.**
#
## keep our interaction layer
#-keep class za.co.nedbank.nid_sdk.main.interaction.** { *; }
#
## keep second Login Layer
#-keep class za.co.nedbank.nid_sdk.main.views.login.LoginContainerFragment { *; }
#-keep class za.co.nedbank.nid_sdk.main.views.pin_biometric.PinBiometricFlows { *; }
#-keep class za.co.nedbank.nid_sdk.main.views.login.LoginUseCaseManager { *; }
#
## keep SBS specific stuff
#-keep class za.co.nedbank.nid_sdk.main.views.sbs.context_switch.model.** { *; }
#
#-keepnames class * implements java.io.Serializable
#-adaptresourcefilenames    **.properties,**.gif,**.jpg
#-adaptresourcefilecontents **.properties,META-INF/MANIFEST.MF
#
## keep class members of R
#-keepclassmembers class **.R$* {public static <fields>;}
#
#-dontwarn sun.misc.Unsafe
#
## Retrofit
#-dontwarn org.codehaus.mojo.**
#-keep class retrofit2.** { *; }
#-keepattributes Signature
#-keepattributes Exceptions
#-keepattributes *Annotation*
#
#-keepattributes RuntimeVisibleAnnotations
#-keepattributes RuntimeInvisibleAnnotations
#-keepattributes RuntimeVisibleParameterAnnotations
#-keepattributes RuntimeInvisibleParameterAnnotations
#-keepattributes InnerClasses
#
#
#-keepattributes EnclosingMethod
#
#-keepclasseswithmembers class * {
#    @retrofit2.* <methods>;
#}
#
#-keepclasseswithmembers interface * {
#    @retrofit2.* <methods>;
#}
#
#-keepattributes Signature, InnerClasses, EnclosingMethod
#
## Retain service method parameters when optimizing.
#-keepclassmembers,allowshrinking,allowobfuscation interface * {
#    @retrofit2.http.* <methods>;
#}
#
#-keep class za.co.nedbank.nid_sdk.base.data.metadata.** { *; }
#-keep class za.co.nedbank.nid_sdk.main.data.model.** { *; }
#-keep class za.co.nedbank.nid_sdk.main.core.model.** { *; }
#-keep class za.co.nedbank.nid_sdk.main.domain.model.** { *; }
#
#-keepclassmembers class za.co.nedbank.nid_sdk.base.data.metadata.** { *; }
#-keepclassmembers class za.co.nedbank.nid_sdk.main.data.model.** { *; }
#-keepclassmembers class za.co.nedbank.nid_sdk.main.core.model.** { *; }
#-keepclassmembers class za.co.nedbank.nid_sdk.main.domain.model.** { *; }
#
#-keepclassmembers class * implements android.os.Parcelable {
#     public static final android.os.Parcelable$Creator *;
#}
#
#-keepclassmembers enum * {
#	public static **[] values();
#	public static ** valueOf(java.lang.String);
#}
#
## Entersekt
#-keep class com.Entersekt.Sdk.** { *; }
#-keep public class * implements za.co.nedbank.nid_sdk.main.core.transakt.dto.Dto { *; }
#
#
#-dontwarn okhttp3.internal.platform.*
#-dontwarn com.squareup.okhttp3.**
#-keep class com.squareup.okhttp3.** { *; }
#-keep interface com.squareup.okhttp3.** { *; }
#
#
#-keep,allowobfuscation @interface za.co.nedbank.nid_sdk.main.core.DoNotObsfucate
#
## Do not strip any method/class that is annotated with @DoNotObsfucate
#-keep @za.co.nedbank.nid_sdk.main.core.DoNotObsfucate public class *
#-keepclassmembers @za.co.nedbank.nid_sdk.main.core.DoNotObsfucate public class * { *; }
#-keepclassmembers class * {
#    @za.co.nedbank.nid_sdk.main.core.DoNotObsfucate *;
#}
#
##Android X related
#-dontwarn com.google.android.material.**
#-keep class com.google.android.material.** { *; }
#
#-dontwarn androidx.**
#-keep class androidx.** { *; }
#-keep interface androidx.** { *; }
#-keep class kotlin.reflect.jvm.internal.impl.builtins.BuiltInsLoaderImpl
#
#-keepclassmembers class kotlin.Metadata {
#    public <methods>;
#}
## Retrofit does reflection on generic parameters. InnerClasses is required to use Signature and
## EnclosingMethod is required to use InnerClasses.
#-keepattributes Signature, InnerClasses, EnclosingMethod
#
## Retrofit does reflection on method and parameter annotations.
#-keepattributes RuntimeVisibleAnnotations, RuntimeVisibleParameterAnnotations
#
## Retain service method parameters when optimizing.
#-keepclassmembers,allowshrinking,allowobfuscation interface * {
#    @retrofit2.http.* <methods>;
#}
#
## Ignore annotation used for build tooling.
#-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
#
## Ignore JSR 305 annotations for embedding nullability information.
#-dontwarn javax.annotation.**
#
## Guarded by a NoClassDefFoundError try/catch and only used when on the classpath.
#-dontwarn kotlin.Unit
#
## Top-level functions that can only be used by Kotlin.
#-dontwarn retrofit2.KotlinExtensions
#-dontwarn retrofit2.KotlinExtensions$*
#
-keep class tvi.webrtc.** { *; }
-keep class com.twilio.video.** { *; }
-keep class com.twilio.common.** { *; }
-keepattributes InnerClasses
## With R8 full mode, it sees no subtypes of Retrofit interfaces since they are created with a Proxy
## and replaces all potential values with null. Explicitly keeping the interfaces prevents this.
#-if interface * { @retrofit2.http.* <methods>; }
#-keep,allowobfuscation interface <1>
#-dontwarn org.jetbrains.annotations.**
#-keep class kotlin.Metadata { *; }
#
#-keep public class * extends com.squareup.moshi.JsonAdapter {
#    <init>(...);
#    <fields>;
#}