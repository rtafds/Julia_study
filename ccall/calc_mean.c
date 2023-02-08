double mean(double a, double b) {
    return (a + b) / 2;
}

/* ビルドコマンド
gcc -shared -fPIC -o libmean.so calc_mean.c 
*/