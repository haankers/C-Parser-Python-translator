int f(int a, int b, int c, int d)
{
    if(a)
        if(b)
            a=23;
            return a;
        else
            a=7;
            return a;
}

int main(){
    return f(1,2,3,4);
}