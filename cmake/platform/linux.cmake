
message(STATUS "Generating linux build config")
set(SDK_INSTALL_BINARY_PREFIX "linux")

include(CheckCXXSourceCompiles)
include(CMakePushCheckState)
include(CheckLibraryExists)

set(ATOMIC_TEST_CXX_SOURCE "
#include <cstdint>
#include <atomic>
std::atomic<uintptr_t> x;
std::atomic<uintmax_t> y;
int main() {
    return x + y;
}")

set(LIBATOMIC_TEST_CXX_SOURCE "
int main() {
    __atomic_load_8(nullptr, 0);
    return 0;
}")

macro(apply_post_project_platform_settings)
    include(GNUInstallDirs)

    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(SDK_INSTALL_BINARY_PREFIX "${SDK_INSTALL_BINARY_PREFIX}/intel64")
    else()
        set(SDK_INSTALL_BINARY_PREFIX "${SDK_INSTALL_BINARY_PREFIX}/ia32")
    endif()

    set(PLATFORM_DEP_LIBS pthread)
    set(PLATFORM_DEP_LIBS_ABSTRACT_NAME pthread)
endmacro()
