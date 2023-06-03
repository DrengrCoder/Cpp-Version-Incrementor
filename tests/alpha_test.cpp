#define CATCH_CONFIG_MAIN

#include <iostream>

#include "dylanclibs/catch.hpp"

TEST_CASE("Test case title", "[single-file]")
{
    std::cout << "Test case log line";

    int i = 1;
    int j = 2;

    int q = 0;

    REQUIRE(i+j == 3);
}