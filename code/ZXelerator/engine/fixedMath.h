#pragma once

#include <stdint.h>

/// @brief Convert a float to 16.16 fixed point
#define FIXED16(f)      ((int32_t)((f)*65536.0f))
#define FIXED16_ONE     0x10000

// Rounding divisions (d must be positive). The 32 bit versions use the Cortex-M33's hardware divider - 64 bit
// division has no hardware support there and is done in software (roughly 100-200 cycles), so it is only
// used as a fallback when values don't fit in 32 bits

static inline int32_t floorDiv32(int32_t a, int32_t d)
{
    const int32_t q=a/d;
    return ((q*d)!=a && a<0)?q-1:q;
}

static inline int32_t ceilDiv32(int32_t a, int32_t d)
{
    const int32_t q=a/d;
    return ((q*d)!=a && a>0)?q+1:q;
}

static inline int64_t floorDiv64(int64_t a, int64_t d)
{
    return (a>=0)?(a/d):-((-a+d-1)/d);
}

static inline int64_t ceilDiv64(int64_t a, int64_t d)
{
    return -floorDiv64(-a,d);
}

/// @brief True if v can safely use a 32 bit division - INT32_MIN is excluded, as dividing it by -1 overflows
/// (compilers may turn a/(-d) into -(a/d), so this can happen even with a positive divisor)
static inline int fitsInt32(int64_t v)
{
    return v>INT32_MIN && v<=INT32_MAX;
}

/// @brief Narrow the step range [*start,*end) so that 0 <= p0+(i*dp) < lim for every step i within it.
/// Used to find which pixels along a line map inside a source image, so the per pixel loop needs no bounds checks
/// @param p0 Source position at step 0 (16.16)
/// @param dp Source step per pixel (16.16)
/// @param lim Source size (16.16), must be positive
static inline void clipSpan(int32_t p0, int32_t dp, int32_t lim, int *start, int *end)
{
    int64_t lo, hi;
    if(dp==0){
        if(p0<0 || p0>=lim){
            *end=*start;
        }
        return;
    }
    if(dp>0){
        // First step with p0+i*dp >= 0, and first step with p0+i*dp >= lim
        const int64_t a=-(int64_t)p0;
        const int64_t b=(int64_t)lim-p0;
        if(fitsInt32(a) && fitsInt32(b)){
            lo=ceilDiv32((int32_t)a,dp);
            hi=ceilDiv32((int32_t)b,dp);
        }else{
            lo=ceilDiv64(a,dp);
            hi=ceilDiv64(b,dp);
        }
    }else{
        // Moving backwards: first step with p0+i*dp < lim, and first step with p0+i*dp < 0
        const int64_t a=(int64_t)p0-lim;
        if(dp!=INT32_MIN && fitsInt32(a) && fitsInt32(p0)){
            lo=(int64_t)floorDiv32((int32_t)a,-dp)+1;
            hi=(int64_t)floorDiv32(p0,-dp)+1;
        }else{
            lo=floorDiv64(a,-(int64_t)dp)+1;
            hi=floorDiv64(p0,-(int64_t)dp)+1;
        }
    }
    if(lo>*start){
        *start=(lo>*end)?*end:(int)lo;
    }
    if(hi<*end){
        *end=(hi<*start)?*start:(int)hi;
    }
}
