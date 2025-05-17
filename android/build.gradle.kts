// allprojects {
//     repositories {
//         google()
//         mavenCentral()
//     }
//     dependencies {
//         classpath("com.google.gms:google-services:4.3.15")
//     }
// }

// val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
// rootProject.layout.buildDirectory.value(newBuildDir)

// subprojects {
//     val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//     project.layout.buildDirectory.value(newSubprojectBuildDir)
// }
// subprojects {
//     project.evaluationDependsOn(":app")
// }

// tasks.register<Delete>("clean") {
//     delete(rootProject.layout.buildDirectory)
// }

import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

// ✅ Firebase plugin setup
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Required for Firebase (Firestore, Auth, etc.)
        classpath("com.google.gms:google-services:4.3.15")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Optional: Custom build output directory (used by Flutter to keep it clean)
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Ensure app module is evaluated before others
subprojects {
    project.evaluationDependsOn(":app")
}

// Clean task for `flutter clean`
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

