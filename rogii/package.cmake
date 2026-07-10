if(TARGET QWindowKit::Widgets)
    return()
endif()

foreach(name Core Widgets)
    add_library(QWindowKit::${name} SHARED IMPORTED)

    if(MSVC)
        set_target_properties(
            QWindowKit::${name}
            PROPERTIES
            IMPORTED_LOCATION
                "${CMAKE_CURRENT_LIST_DIR}/bin/QWK${name}.dll"
            IMPORTED_LOCATION_DEBUG
                "${CMAKE_CURRENT_LIST_DIR}/bin/QWK${name}d.dll"
            IMPORTED_IMPLIB
                "${CMAKE_CURRENT_LIST_DIR}/lib/QWK${name}.lib"
            IMPORTED_IMPLIB_DEBUG
                "${CMAKE_CURRENT_LIST_DIR}/lib/QWK${name}d.lib"
            INTERFACE_INCLUDE_DIRECTORIES
                "${CMAKE_CURRENT_LIST_DIR}/include/QWindowKit/"
        )
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set_target_properties(
            ShapeLib::library
            PROPERTIES
            IMPORTED_LOCATION
                "${CMAKE_CURRENT_LIST_DIR}/lib/QWK${name}.so"
            IMPORTED_LOCATION_DEBUG
                "${CMAKE_CURRENT_LIST_DIR}/lib/QWK${name}d.so"
            INTERFACE_INCLUDE_DIRECTORIES
                "${CMAKE_CURRENT_LIST_DIR}/include/QWindowKit/"
        )
    endif()
endforeach()

set(
    COMPONENT_NAMES

    CNPM_RUNTIME_QWindowKit
    CNPM_RUNTIME
)

foreach(COMPONENT_NAME ${COMPONENT_NAMES})
    install(
        FILES
            $<TARGET_FILE:QWindowKit::Core>
            $<TARGET_FILE:QWindowKit::Widgets>
        DESTINATION
            .
        COMPONENT
            ${COMPONENT_NAME}
        EXCLUDE_FROM_ALL
    )
endforeach()
