set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)

include_directories(${PROJECT_SOURCE_DIR}/include)

aux_source_directory(. DIR_SRCS)
if (CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
    list(APPEND DIR_SRCS "tc_jump_aarch64_sysv_elf_gas.s")
    list(APPEND DIR_SRCS "tc_make_aarch64_sysv_elf_gas.s")

else()
    if (CMAKE_SIZEOF_VOID_P EQUAL 8)
        list(APPEND DIR_SRCS "tc_jump_x86_64_sysv_elf_gas.s")
        list(APPEND DIR_SRCS "tc_make_x86_64_sysv_elf_gas.s")
    else ()
        list(APPEND DIR_SRCS "tc_jump_i386_sysv_elf_gas.s")
        list(APPEND DIR_SRCS "tc_make_i386_sysv_elf_gas.s")
   endif ()
endif ()
add_library(tarsutil ${DIR_SRCS})

if(${TARS_SSL} EQUAL 1)
    target_link_libraries(tarsutil; crypto; ssl)
else()
    target_link_libraries(tarsutil)
endif()
if(${TARS_HTTP2} EQUAL 1)
    target_link_libraries(tarsutil; nghttp2)
else()
    target_link_libraries(tarsutil)
endif()

install(TARGETS tarsutil
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)
