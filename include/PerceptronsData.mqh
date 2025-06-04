// Define Macros
#ifndef __DEPTH_NETWORK__
#define __DEPTH_NETWORK__

// inputs RSI perceptron
extern int x1 = 0;
extern int x2 = 0;
extern int x3 = 0;
extern int x4 = 0;

// inputs CCI perceptron
extern int x11 = 0;
extern int x21 = 0;
extern int x31 = 0;
extern int x41 = 0;


// Method to normalize values in [0,1]
// This method is use to normalize all values, all tickets
double Normalize(double value, double min, double max){
   
   return (value- min)/ (max - min);

}

#endif