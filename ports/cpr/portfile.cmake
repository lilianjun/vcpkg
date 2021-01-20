vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO lilianjun/cpr
    REF d81fdcbc560d2ff2685750f0c27773fa2995083e # v1.5.3_2
    SHA512 c8cae3127f3794ea584c7b4da3cf49f7a59443582e9d06a55dc17f3aeaa70f704326720932689b4cd935011ea9661ddd17c6330e543e05521c0ee074c18da58e
    HEAD_REF master
    PATCHES
        001-cpr-config.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS 
        -DBUILD_CPR_TESTS=OFF
        -DUSE_SYSTEM_CURL=ON
    OPTIONS_DEBUG
        -DDISABLE_INSTALL_HEADERS=ON
)

vcpkg_install_cmake()

file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/cprConfig.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/lib/cmake/cpr)
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/cpr)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
