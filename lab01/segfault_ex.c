int main() {
    int a[20];
//    for (int i = 0; ; i++) {
    for (int i = 0; i < sizeof(a) / sizeof(a[0]); i++) {
        a[i] = i;
    }
}