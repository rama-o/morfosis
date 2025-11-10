import java.util.Properties
import java.io.FileInputStream

val envProperties = Properties()
val envFile = rootProject.file(".env")
if (envFile.exists()) {
    envProperties.load(FileInputStream(envFile))
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.rama.morfosis"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

		signingConfigs {
        create("release") {
					 fun getEnv(key: String): String =
    envProperties[key]?.toString()?.takeIf { it.isNotBlank() }
        ?: error("$key is missing in .env")

storeFile = file(getEnv("KEYSTORE_PATH"))
storePassword = getEnv("KEYSTORE_PASSWORD")
keyAlias = getEnv("KEY_ALIAS")
keyPassword = getEnv("KEY_PASSWORD")
        }
    }

    defaultConfig {
        applicationId = "com.rama.morfosis"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
						signingConfig = signingConfigs.getByName("release")
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}
