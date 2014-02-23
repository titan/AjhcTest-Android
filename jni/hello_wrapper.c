#include <jni.h>

void hs_init(int * argc, char * (* argv)[]);
void hs_exit(void);
char * hello();

jint JNI_OnLoad(JavaVM * vm, void * reserved) {
    int argc = 1;
    char * argv[2];
    argv[0] = "dummy";
    argv[1] = 0;
    hs_init(&argc, &argv);
    return JNI_VERSION_1_4;
}

void JNI_OnUnload(JavaVM * vm, void * reserved) {
    hs_exit();
}

jstring Java_com_alicestudio_MainActivity_hello(JNIEnv * env, jobject thiz) {
    return (*env)->NewStringUTF(env, hello());
}
