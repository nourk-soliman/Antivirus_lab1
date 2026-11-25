#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <string.h>



int main(int argc, char *argv[]){
    if(argc!=6){
        printf("Invalid number of arguments (should be 5).\n");
        return 1;
    }
    char name[10];
    double mean,deviation;
    int sleepTime,bufferSize;
    char*end;

    if(strlen(argv[1])>=10){
        printf("Length of commodity name exceeded.\n");
    }
    else{
        strcpy(name,argv[1]);
    }
    
    mean = strtod(argv[2], &end);

    if (end == argv[2] || *end != '\0') {
        printf("Invalid mean input.\n");
        return 1;
    }
    deviation = strtod(argv[3], &end);

    if (end == argv[3] || *end != '\0') {
        printf("Invalid standard deviation input.\n");
        return 1;
    }
    
    sleepTime = strtol(argv[4], &end, 10);

    if (end == argv[4] || *end != '\0') {
        printf("Invalid sleep time input.\n");
        return 1;
    }
    bufferSize = strtol(argv[5], &end, 10);

    if (end == argv[5] || *end != '\0') {
        printf("Invalid buffersize input.\n");
        return 1;
    }
    













    return 0;
}