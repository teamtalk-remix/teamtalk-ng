     //
//  main.cpp
//  my_push_server
//
//  Created by luoning on 14-11-4.
//  Copyright (c) 2014年 luoning. All rights reserved.
//

#include <iostream>
#include "push_app.h"
#include "timer/Timer.hpp"
#include <sys/signal.h>

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("start push server...\n");
    signal(SIGPIPE, SIG_IGN);
    CPushApp::GetInstance()->Init();
    CPushApp::GetInstance()->Start();
    // writePid();
    while (true) {
        S_Sleep(1000);
    }
    return 0;
}
