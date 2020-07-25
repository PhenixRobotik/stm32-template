# Given a git target, define TARGET_URL and TARGET_TAG variables  to the default
# given strings (str_url, str_tag) or to CONFIG_TARGET_SET_URL and
# CONFIG_TARGET_SET_TAG respectively if defined
macro(set_git_cfg
      str_target # Name of the target
      str_url # Default URL
      str_tag # Default tag
)
    string(TOUPPER ${str_target} target_u)
    set(var_url CONFIG_${target_u}_SET_URL)
    set(var_tag CONFIG_${target_u}_SET_TAG)
    if(NOT CONFIG_${target_u}_SET_TAG)
        message(WARNING "No tag set for ${str_target}, using ${str_tag}")
        set(${target_u}_TAG "${str_tag}")
    else()
        set(${target_u}_TAG "${${var_tag}}")
    endif()
    
    if(NOT CONFIG_${target_u}_SET_URL)
        set(${target_u}_URL "${str_url}")
    else()
        set(${target_u}_URL "${${var_url}}")
        message("Using URL ${${var_url}} for ${str_target}")
    endif()
endmacro()