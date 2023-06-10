#ifndef LIBINIT_DALVIK_HEAP_H
#define LIBINIT_DALVIK_HEAP_H

#include <string>

typedef struct dalvik_heap_info {
    std::string heapstartsize;
    std::string heapgrowthlimit;
    std::string heapsize;
    std::string heapminfree;
    std::string heapmaxfree;
    std::string heaptargetutilization;
} dalvik_heap_info_t;

void set_dalvik_heap(void);

#endif