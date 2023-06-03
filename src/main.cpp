#include <iostream>

#include "dylanclibs/log.h"

LogSettings LOG_SETTINGS;

int main(int argc, char* argv[]){
    std::cout << "Testing line\n";
    
    //  TODO:   Need to

    LOG_SETTINGS.ls_use_working_dir = false;
    LOG_SETTINGS.ls_print_to_file = false;
    
    try {
        LogInit(argv);
    } catch (std::runtime_error &err) {
        std::cout << err.what() << std::endl;
        exit(0);
    } catch (std::exception &e) {
        std::cout << "Program is unable to start: " << e.what() << std::endl;
        exit(0);
    }

    LogShutdown;
    return 0;
}
