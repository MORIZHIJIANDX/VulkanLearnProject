vulkan_sdk_path = "D:/VulkanSdk"
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

workspace "VulkanLearnProject"
    architecture "x64"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"
    cdialect "C17"

    targetdir ("Bin/"..outputdir.."/%{prj.name}")
    objdir ("Bin-Intermediate/"..outputdir.."/%{prj.name}")

    characterset ("MBCS")

    libdirs { vulkan_sdk_path.."/Lib" }
    libdirs { "%{wks.location}/ThirdParty/glfw/lib-vc2022" }

    files
    {
        "%{prj.name}/Src/**.h",
        "%{prj.name}/Src/**.cpp"
    }

    includedirs
    {
        vulkan_sdk_path.."/Include",
        "%{wks.location}/ThirdParty/glm",
        "%{wks.location}/ThirdParty/glfw/include",
    }

    links
    {
        "vulkan-1",
        "glfw3"
    }

    configurations
    {
        "Debug",
        "Release",
    }

    flags
	{
        --多核并行编译
		"MultiProcessorCompile"
	}

    filter "system:windows"
        systemversion "latest"

    startproject "VulkanSetup"

project "VulkanSetup"
    location "VulkanSetup"

    defines { 'PROJECT_PATH="' .. path.join(path.getabsolute(""), "%{prj.name}") .. '"' }

    filter "configurations:Debug"
        defines "BUILD_DEBUG"
        symbols "On"
        staticruntime "off"
        runtime "Debug"

    filter "configurations:Release"
        defines "BUILD_RELEASE"
        optimize "On"
        staticruntime "on"

project "DrawTriangle"
    location "DrawTriangle"

    defines { 'PROJECT_PATH="' .. path.join(path.getabsolute(""), "%{prj.name}") .. '"' }

    filter "configurations:Debug"
        defines "BUILD_DEBUG"
        symbols "On"
        staticruntime "off"
        runtime "Debug"

    filter "configurations:Release"
        defines "BUILD_RELEASE"
        optimize "On"
        staticruntime "on"