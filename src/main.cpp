#include <iostream>

#include "dylanclibs/log.h"
#include "dylanclibs/cli_parser.h"

LogSettings LOG_SETTINGS;

int main(int argc, char* argv[]){

    //  Will leave these values false always, as they will not be required for
    //  the make, cmake or build file building the main executable of a given
    //  project binary.
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

    ParserOption headerFilePath = ParserOption(
        {"p", "header file path"},
        "The location of the version number header file.",
        true,
        "path to header");

    ParserOption versionNumber = ParserOption(
        {"n", "version number"},
        "Version number to increment.",
        {"MAJOR", "MINOR", "PATCH", "BUILD"},
        std::string("BUILD"));

    Parser parser = Parser(argc, argv, "Automatically increments version numbers "
            "in a header file for a project.");

    parser.AddHelpOption();
    parser.AddVersionOption();
    int r = parser.AddOptions({headerFilePath, versionNumber});
    if (r != 0){
        elog << "Failed adding some options to the parser: " << r;
    }

    if (parser.Process()){

    }else{
        flog << "Failed to parse args.";
    }

    LogShutdown;
    return 0;
}
