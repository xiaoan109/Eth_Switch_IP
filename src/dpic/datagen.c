/*
 * @FilePath       : /Switch/src/dpic/datagen.c
 * @Author         : wangxuanji 18364998790@163.com
 * @CreateDate     : 24-05-20
 * @LastEditors    : wangxuanji 18364998790@163.com
 * @LastEditTime   : 24-05-20
 * Version        :
 * @Description    : 
 *                  
 * 
 * Parameter       :
 *                  
 * 
 * IO Port         :
 *                  
 * 
 * Modification History
 *    Date   |   Author   |   Version   |   Change Description
 * ==============================================================================
 *  23-08-24 |     NJU    |     0.1     | Original Version
 *                  
 * 
 */
#include <stdio.h>
#include "svdpi.h"
#include <math.h>

int float_to_q31_f(double x){
    return ((int)((x) < 1 ? ((x) >= -1 ? (x)*0x80000000 : 0x80000000) : 0x7FFFFFFF));
}

int SIN(double degree) {
    const double pi = acos(-1.0);
    double r, ret;
    r = degree*pi/180;
    ret = float_to_q31_f(sin(r));
    // printf("sin(%f) = %f\n", degree, ret);
    return ret;
}
