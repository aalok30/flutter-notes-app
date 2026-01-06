
#========= CometChat ProGuard Rules Start =========
-keep class com.cometchat.** { *; }
-keep interface com.cometchat.** { *; }
-keepattributes Signature
-keepattributes InnerClasses
-dontwarn com.cometchat.**
#========= CometChat ProGuard Rules End ===========

#========= Apache Tika / javax.xml Rules Start ====
-keep class javax.xml.stream.** { *; }
-dontwarn javax.xml.stream.**
-keep class org.apache.tika.** { *; }
-dontwarn org.apache.tika.**
#========= Apache Tika / javax.xml Rules End ======
