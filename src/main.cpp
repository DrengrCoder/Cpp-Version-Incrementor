#include <iostream>
#include <fstream>

#include "dylanclibs/log.h"
#include "dylanclibs/cli_parser.h"
#include "dylanclibs/string.h"

#include "version_number.h"

LogSettings LOG_SETTINGS;

int main(int argc, char* argv[]){

    //  Will leave these values false always, as they will not be required for
    //  the make, cmake or build file building the main executable of a given
    //  project binary.
    LOG_SETTINGS.ls_use_working_dir = false;
    LOG_SETTINGS.ls_print_to_file = false;
    LOG_SETTINGS.ls_selected_level = LogType::Value::LT_INFO;
    
    try {
        LogInit(argv);
    } catch (std::runtime_error &err) {
        std::cout << err.what() << std::endl;
        exit(0);
    } catch (std::exception &e) {
        std::cout << "Program is unable to start: " << e.what() << std::endl;
        exit(0);
    }

    std::stringstream verSs;
    verSs << VERSION_MAJOR_N << "." << VERSION_MINOR_N << "." << VERSION_PATCH_N;

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
            "in a header file for a project.", verSs.str());

    parser.AddHelpOption();
    parser.AddVersionOption();
    int r = parser.AddOptions({headerFilePath, versionNumber});
    if (r != 0){
        elog << "Failed adding some options to the parser: " << r;
    }

    if (!parser.Process()){
        flog << "Failed to parse args.";
    } else {
        //  Define the strings for the version number options to compare against
        const String ver_build_str = "BUILD";
        const String ver_patch_str = "PATCH";
        const String ver_minor_str = "MINOR";
        const String ver_major_str = "MAJOR";

        //  Get the values from the parser options
        String filepath = parser.GetValue(headerFilePath);
        String verNum = parser.GetValue(versionNumber);

        //  Open and read the header file, or create a new one
        std::ifstream ifs;
        ifs.open(filepath.c_str());

        //  Define some local variables to store the current version numbers
        int major = 0;
        int minor = 0;
        int patch = 0;
        int build = 0;

        //  If we couldn't open the file, it doesn't exist...
        if (!ifs){
            //  ... So create it and initialise the text
            clog << "File does not exist, creating file...";
            std::ofstream ofs;
            ofs.open(filepath.c_str());
            ofs << "#define VERSION_MAJOR_N 0\n"
                << "#define VERSION_MINOR_N 0\n"
                << "#define VERSION_PATCH_N 0\n"
                << "#define VERSION_BUILD_N 0\n"
                << std::endl;
            ofs.close();
        } else {
            //  If we could open it, it exists, read the data
            clog << "File exists, reading data...";

            //  Get each line of the file and append it to a local String object
            std::string output;
            String totalContent;
            while (std::getline(ifs, output)){
                totalContent += output + "\n";
            }

            //  Split the output on each new line and loop them
            std::vector<String> splitContent = totalContent.split('\n');
            for (String str : splitContent){

                //  Split each line on space to get the parts of the text
                std::vector<String> lineContent = str.split(' ');
                //  The numeric value is the last item so get the last item
                String value = lineContent[lineContent.size() - 1];

                //  Convert the value to an integer and set the appropriate local variable
                if (str.contains(ver_build_str.c_str())){
                    build = std::stoi(value);
                } else if (str.contains(ver_patch_str.c_str())){
                    patch = std::stoi(value);
                } else if (str.contains(ver_minor_str.c_str())){
                    minor = std::stoi(value);
                } else if (str.contains(ver_major_str.c_str())){
                    major = std::stoi(value);
                }
            }
        }

        ifs.close();

        //  Check which number was requested to be incremented and appropriately
        //      adjust values
        if (strcmp(verNum, ver_build_str.c_str()) == 0){

            clog << "Build Number Identified.";
            build++;

        } else if (strcmp(verNum, ver_patch_str.c_str()) == 0){

            clog << "Patch Number Identified.";
            build = 0;
            patch++;

        } else if (strcmp(verNum, ver_minor_str.c_str()) == 0){

            clog << "Minor Number Identified.";
            build = 0;
            patch = 0;
            minor++;

        } else if (strcmp(verNum, ver_major_str.c_str()) == 0){

            clog << "Major Number Identified.";
            build = 0;
            patch = 0;
            minor = 0;
            major++;

        } else {
            flog << "Error occurred identifying build number from the parser: \""
                << verNum << "\".";
        }

        //  Rewrite the header file, delete it and start again
        std::ofstream ofs;
        ofs.open(filepath.c_str());
        ofs << "#define VERSION_MAJOR_N " << major << "\n"
            << "#define VERSION_MINOR_N " << minor << "\n"
            << "#define VERSION_PATCH_N " << patch << "\n"
            << "#define VERSION_BUILD_N " << build << "\n"
            << std::endl;
    }

    ilog << "Incremented version.";

    LogShutdown;
    return 0;
}
